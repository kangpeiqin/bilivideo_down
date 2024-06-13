import 'package:bilivideo_down/constant/http_api.dart';
import 'package:bilivideo_down/controller/wait_download_controller.dart';
import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:bilivideo_down/entity/video_play_info_entity.dart';
import 'package:bilivideo_down/entity/video_sec_entity.dart';
import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:bilivideo_down/views/widget/custom_toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BiliVideoSearchController extends GetxController {
  var episodeList = <Episode>[].obs;
  var isLoading = false.obs;
  TextEditingController controller = TextEditingController();
  var waidtDownController = Get.find<WaitDownloadController>();

  void handleSearch(String input, BuildContext context, GlobalKey inputKey) {
    final RegExp regExp = RegExp(r'BV[\w]+');
    final match = regExp.firstMatch(input);
    final msgToast = CustomToast(context: context, inputKey: inputKey);
    if (match != null) {
      msgToast.message = "视频链接解析中...";
      msgToast.iconWidget = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.white,
        ),
      );
      fetchVideoInfo(match.group(0)!, msgToast, context, inputKey);
    } else {
      msgToast.message = "错误的B站视频链接";
      msgToast.iconWidget = const Icon(Icons.close, color: Colors.red);
      msgToast.showInDuration();
    }
  }

  void fetchVideoInfo(String bv, CustomToast msgToast, BuildContext context,
      GlobalKey inputKey) async {
    try {
      msgToast.showInDuration();
      isLoading(true);
      await DioUtil.instance.requestNetwork<VideoSecEntity>(
          Method.get, HttpApi.biliBiliViewUrl, queryParameters: {'bvid': bv},
          onSuccess: (data) async {
        if (data != null) {
          episodeList.clear();
          final ugcSeason = data.ugcSeason;
          if (ugcSeason != null) {
            episodeList.addAll(ugcSeason.sections[0].episodes);
          } else {
            try {
              await DioUtil.instance.requestNetwork<VideoPlayInfoEntity>(
                  Method.get, HttpApi.biliBiliVideoPlayUrl,
                  queryParameters: {
                    'avid': data.aid,
                    'cid': data.cid,
                    'qn': 80,
                    'platform': 'html5',
                    'otype': 'json',
                    'high_quality': 1
                  }, onSuccess: (infoData) async {
                if (infoData != null) {
                  bool exist = waidtDownController.exist(data.bvid);
                  if (!exist) {
                    Durl durl = infoData.durl[0];
                    VideoInfoEntity infoEntity = VideoInfoEntity(
                        bvid: data.bvid,
                        aid: data.aid,
                        cid: data.cid,
                        pic: data.pic,
                        title: data.title,
                        pubdate: data.pubdate,
                        ctime: data.ctime,
                        desc: "",
                        duration: durl.length,
                        playUrl: durl.url,
                        size: durl.size);
                    waidtDownController.add(infoEntity);
                  }
                }
              }, onError: (code, msg) {
                debugPrint('$code, $msg');
              });
              routerConfig.replace(RouterPath.download);
            } catch (e) {
              Log.e(e.toString());
            }
          }
        }
      }, onError: (code, msg) {
        final errorToast = CustomToast(
            context: context,
            inputKey: inputKey,
            iconWidget: const Icon(Icons.close, color: Colors.red),
            message: "出错了，请检查链接后重试");
        errorToast.showInDuration();
        debugPrint('$code, $msg');
      });
    } catch (e) {
      Log.e(e.toString());
    } finally {
      msgToast.hide();
      isLoading(false);
    }
  }
}
