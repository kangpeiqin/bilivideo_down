import 'package:bilivideo_down/constant/http_api.dart';
import 'package:bilivideo_down/entity/video_play_info_entity.dart';
import 'package:bilivideo_down/model/video_info.dart';
import 'package:bilivideo_down/provider/video_search_provider.dart';
import 'package:bilivideo_down/provider/wait_download_provider.dart';
import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:bilivideo_down/views/widget/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollapseWidget extends ConsumerStatefulWidget {
  final GlobalKey inputKey;

  const CollapseWidget({super.key, required this.inputKey});

  @override
  ConsumerState<CollapseWidget> createState() => _VideoListViewState();
}

class _VideoListViewState extends ConsumerState<CollapseWidget> {
  bool _selectAll = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 使用 ref.watch 获取最新的状态
    final videoState = ref.watch(videoSearchProvider);
    // 更新选择状态
    _selectAll = videoState.episodes.isNotEmpty &&
        videoState.episodes.every((item) => item.checked);
  }

  void _toggleSelectAll(bool? value) {
    final videoState = ref.read(videoSearchProvider);
    setState(() {
      _selectAll = value ?? false;
      for (var episode in videoState.episodes) {
        episode.checked = _selectAll;
      }
    });
  }

  int get countChecked {
    final videoState = ref.watch(videoSearchProvider);
    return videoState.episodes.where((item) => item.checked).length;
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoSearchProvider);
    final downloadStateService = ref.read(waitDownloadProvider.notifier);
    return ExpansionTile(
      initiallyExpanded: true,
      shape: const Border(),
      title: Text(
        '已选择[$countChecked/${videoState.episodes.length}]',
      ),
      children: [
        SizedBox(
          height: 250.0,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: videoState.episodes.length,
            itemBuilder: (context, index) {
              final episode = videoState.episodes[index];
              return CheckboxListTile(
                value: episode.checked,
                onChanged: (bool? value) {
                  setState(() {
                    episode.checked = value ?? false;
                    _selectAll =
                        videoState.episodes.every((item) => item.checked);
                  });
                },
                title: Text(
                  episode.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _selectAll,
                    onChanged: _toggleSelectAll,
                  ),
                  const Text('全选'),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ),
                onPressed: () async {
                  if (countChecked == 0) {
                    final errorToast = CustomToast(
                        context: context,
                        inputKey: widget.inputKey,
                        iconWidget: const Icon(Icons.notifications,
                            color: Colors.white),
                        message: "至少选择一个视频");
                    errorToast.showInDuration();
                  } else {
                    final loadingToast = CustomToast(
                        context: context,
                        inputKey: widget.inputKey,
                        iconWidget: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        message: "视频数据获取中");
                    loadingToast.show();
                    List<Future<void>> futures = [];
                    videoState.episodes.where((item) => item.checked).forEach(
                      (element) async {
                        // Log.d('---${element.toJson()}');
                        try {
                          futures.add(
                            DioUtil.instance
                                .requestNetwork<VideoPlayInfoEntity>(
                                    Method.get, HttpApi.biliBiliVideoPlayUrl,
                                    queryParameters: {
                                  'avid': element.aid,
                                  'cid': element.cid,
                                  'qn': 80,
                                  'platform': 'html5',
                                  'otype': 'json',
                                  'high_quality': 1
                                }, onSuccess: (data) async {
                              if (data != null) {
                                bool exist =
                                    downloadStateService.exist(element.bvid);
                                if (!exist) {
                                  Durl durl = data.durl[0];
                                  Log.d('视频下载地址：${durl.url}');
                                  VideoInfo infoEntity = VideoInfo(
                                      bvid: element.bvid,
                                      aid: element.aid,
                                      cid: element.cid,
                                      pic: element.arc.pic,
                                      title: element.title,
                                      pubdate: element.arc.pubdate,
                                      ctime: element.arc.ctime,
                                      desc: "",
                                      duration: durl.length,
                                      playUrl: durl.url,
                                      size: durl.size);
                                  downloadStateService.add(infoEntity);
                                }
                              }
                            }, onError: (code, msg) {
                              debugPrint('$code, $msg');
                              //请求异常弹窗
                              final netWorkError = CustomToast(
                                  context: context,
                                  inputKey: widget.inputKey,
                                  iconWidget: const Icon(Icons.wifi,
                                      color: Colors.white),
                                  message: msg);
                              netWorkError.showInDuration();
                            }),
                          );
                        } catch (e) {
                          Log.e(e.toString());
                        }
                      },
                    );
                    await Future.wait(futures);
                    loadingToast.hide();
                    routerConfig.replace(RouterPath.download);
                  }
                },
                child: const Text('下一步'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
