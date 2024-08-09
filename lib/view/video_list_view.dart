import 'package:bilivideo_down/provider/video_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class VideoListView extends ConsumerStatefulWidget {
  final GlobalKey inputKey;

  const VideoListView({super.key, required this.inputKey});

  @override
  ConsumerState<VideoListView> createState() => _CollapseWidgetState();
}

class _CollapseWidgetState extends ConsumerState<VideoListView> {
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    final videoState = ref.watch(videoSearchProvider);
    _selectAll = videoState.episodes.every((item) => item.checked);
  }

  void _toggleSelectAll(bool? value) {
    final videoState = ref.watch(videoSearchProvider);
    setState(() {
      _selectAll = value!;
      for (int i = 0; i < videoState.episodes.length; i++) {
        videoState.episodes[i].checked = _selectAll;
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
    // final searchService = ref.read(videoSearchProvider.notifier);
    return Obx(
      () => ExpansionTile(
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
                return CheckboxListTile(
                  value: videoState.episodes[index].checked,
                  onChanged: (bool? value) {
                    setState(() {
                      videoState.episodes[index].checked = value!;
                      _selectAll =
                          videoState.episodes.every((item) => item.checked);
                    });
                  },
                  title: Text(
                    videoState.episodes[index].title,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                  ),
                  onPressed: () async {
                    // if (countChecked == 0) {
                    //   final errorToast = CustomToast(
                    //       context: context,
                    //       inputKey: widget.inputKey,
                    //       iconWidget: const Icon(Icons.notifications,
                    //           color: Colors.white),
                    //       message: "至少选择一个视频");
                    //   errorToast.showInDuration();
                    // } else {
                    //   final loadingToast = CustomToast(
                    //       context: context,
                    //       inputKey: widget.inputKey,
                    //       iconWidget: const SizedBox(
                    //         width: 20,
                    //         height: 20,
                    //         child: CircularProgressIndicator(
                    //           strokeWidth: 0.5,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       message: "视频数据获取中");
                    //   loadingToast.show();
                    //   List<Future<void>> futures = [];
                    //   searchController.episodeList
                    //       .where((item) => item.checked)
                    //       .forEach(
                    //     (element) async {
                    //       try {
                    //         futures.add(DioUtil.instance
                    //             .requestNetwork<VideoPlayInfoEntity>(
                    //                 Method.get, HttpApi.biliBiliVideoPlayUrl,
                    //                 queryParameters: {
                    //               'avid': element.aid,
                    //               'cid': element.cid,
                    //               'qn': 80,
                    //               'platform': 'html5',
                    //               'otype': 'json',
                    //               'high_quality': 1
                    //             }, onSuccess: (data) async {
                    //           if (data != null) {
                    //             bool exist =
                    //                 waidtDownController.exist(element.bvid);
                    //             if (!exist) {
                    //               Durl durl = data.durl[0];
                    //               LogUtil.d('视频下载地址：${durl.url}');
                    //               VideoInfoEntity infoEntity = VideoInfoEntity(
                    //                   bvid: element.bvid,
                    //                   aid: element.aid,
                    //                   cid: element.cid,
                    //                   pic: element.arc.pic,
                    //                   title: element.title,
                    //                   pubdate: element.arc.pubdate,
                    //                   ctime: element.arc.ctime,
                    //                   desc: "",
                    //                   duration: durl.length,
                    //                   playUrl: durl.url,
                    //                   size: durl.size);
                    //               waidtDownController.add(infoEntity);
                    //             }
                    //           }
                    //         }, onError: (code, msg) {
                    //           debugPrint('$code, $msg');
                    //         }));
                    //       } catch (e) {
                    //         Log.e(e.toString());
                    //       }
                    //     },
                    //   );
                    //   await Future.wait(futures);
                    //   loadingToast.hide();
                    //   routerConfig.replace(RouterPath.download);
                    // }
                  },
                  child: const Text('下一步'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
