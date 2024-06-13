import 'package:bilivideo_down/constant/http_api.dart';
import 'package:bilivideo_down/controller/bili_video_search_controller.dart';
import 'package:bilivideo_down/controller/wait_download_controller.dart';
import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:bilivideo_down/entity/video_play_info_entity.dart';
import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:bilivideo_down/views/widget/custom_toast_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollapseWidget extends StatefulWidget {
  final GlobalKey inputKey;

  const CollapseWidget({super.key, required this.inputKey});

  @override
  State<CollapseWidget> createState() => _CollapseWidgetState();
}

class _CollapseWidgetState extends State<CollapseWidget> {
  bool _selectAll = false; // 用于跟踪是否全选
  var searchController = Get.find<BiliVideoSearchController>();
  var waidtDownController = Get.find<WaitDownloadController>();

  @override
  void initState() {
    super.initState();
    _selectAll = searchController.episodeList.every((item) => item.checked);
  }

  void _toggleSelectAll(bool? value) {
    setState(() {
      _selectAll = value!;
      for (int i = 0; i < searchController.episodeList.length; i++) {
        searchController.episodeList[i].checked = _selectAll;
      }
    });
  }

  int get countChecked {
    return searchController.episodeList.where((item) => item.checked).length;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ExpansionTile(
        initiallyExpanded: true,
        shape: const Border(),
        title: Text(
          '已选择[$countChecked/${searchController.episodeList.length}]',
        ),
        children: [
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: searchController.episodeList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: searchController.episodeList[index].checked,
                  onChanged: (bool? value) {
                    setState(() {
                      searchController.episodeList[index].checked = value!;
                      _selectAll = searchController.episodeList
                          .every((item) => item.checked);
                    });
                  },
                  title: Text(
                    searchController.episodeList[index].title,
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
                      searchController.episodeList
                          .where((item) => item.checked)
                          .forEach(
                        (element) async {
                          try {
                            futures.add(DioUtil.instance
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
                                    waidtDownController.exist(element.bvid);
                                if (!exist) {
                                  Durl durl = data.durl[0];
                                  LogUtil.d('视频下载地址：${durl.url}');
                                  VideoInfoEntity infoEntity = VideoInfoEntity(
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
                                  waidtDownController.add(infoEntity);
                                }
                              }
                            }, onError: (code, msg) {
                              debugPrint('$code, $msg');
                            }));
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
      ),
    );
  }
}
