import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:bilivideo_down/controller/download_complete_controller.dart';
import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:bilivideo_down/util/common_util.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/range_download_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sp_util/sp_util.dart';
import 'package:path/path.dart' as path;

class DownloadingController extends GetxController {
  var videoInfoList = <VideoInfoEntity>[].obs;
  var downloadCompleteController = Get.find<DownloadCompleteController>();

  void add(VideoInfoEntity entity) {
    videoInfoList.add(entity);
  }

  void addUnique(VideoInfoEntity entity) {
    bool exist = videoInfoList.any((e) => e.bvid == entity.bvid);
    if (!exist) {
      videoInfoList.add(entity);
      startDownload(entity.bvid);
    }
  }

  bool exist(String bvid) {
    return videoInfoList.any((e) => e.bvid == bvid);
  }

  void removeAt(int index) {
    videoInfoList.removeAt(index);
  }

  // 更新指定视频的下载进度
  void updateProgress(String bvid, double progress, String progressMsg) {
    var video = videoInfoList.firstWhereOrNull((e) => e.bvid == bvid);
    if (video != null) {
      video.progress = progress;
      video.progressMsg = progressMsg;
      videoInfoList.refresh(); // 通知监听者数据已更新
    }
  }

  void updateDownStatus(String bvid, bool downStatus) {
    var video = videoInfoList.firstWhere((e) => e.bvid == bvid);
    video.downStatus = downStatus;
    videoInfoList.refresh();
  }

  VideoInfoEntity getVideoInfoByBvid(String bvid) {
    var video = videoInfoList.firstWhere((e) => e.bvid == bvid);
    return video;
  }

  bool getVideoDownStatus(String bvid) {
    var video = videoInfoList.firstWhere((e) => e.bvid == bvid);
    return video.downStatus;
  }

  double getProgress(String bvid) {
    var video = videoInfoList.firstWhereOrNull((e) => e.bvid == bvid);
    if (video != null) {
      return video.progress;
    }
    return 0.0;
  }

  String getProgressMsg(String bvid) {
    var video = videoInfoList.firstWhereOrNull((e) => e.bvid == bvid);
    if (video != null) {
      return video.progressMsg;
    }
    return '待下载';
  }

  Future<void> startDownload(String bvid) async {
    String storagePath = SpUtil.getString(SpKey.storagePath) ?? '';
    if (storagePath.isEmpty) {
      storagePath = (await getDownloadsDirectory())!.path;
      SpUtil.putString(SpKey.storagePath, storagePath);
    }
    VideoInfoEntity video = getVideoInfoByBvid(bvid);

    final String url = video.playUrl;
    String currentDate =
        DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d);

    String savePath = path.join(storagePath, '下载合集_$currentDate');
    final String fileName = path.join(savePath, '${video.title}.mp4');
    updateDownStatus(bvid, true);

    video.location = savePath;
    downloadFile(url, fileName, video);
  }

  Future<void> downloadFile(
      String url, String savePath, VideoInfoEntity video) async {
    try {
      video.cancelToken = CancelToken();
      await RangeDownloadUtil.downloadWithChunks(
        url,
        savePath,
        dio: DioUtil.instance.dio,
        onReceiveProgress: (count, total) {
          if (total != -1) {
            '${CommonUtil.formatBytes(count)} / ${CommonUtil.formatBytes(total)}';
            updateProgress(video.bvid, count / total,
                '${CommonUtil.formatBytes(count)} / ${CommonUtil.formatBytes(total)}');
          }
        },
        cancelToken: video.cancelToken,
      ).then((val) {
        LogUtil.d('下载成功: ${val.statusCode}');
        final newList = List<VideoInfoEntity>.from(videoInfoList);
        newList.removeWhere((element) => element.bvid == video.bvid);
        videoInfoList.assignAll(newList);
        downloadCompleteController.addVideo(video);
      }).catchError((error) {
        LogUtil.e('下载失败: $error');
      });
    } catch (e) {
      LogUtil.e("下载失败");
    }
  }
}
