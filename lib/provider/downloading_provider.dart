import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:bilivideo_down/model/downloading_state.dart';
import 'package:bilivideo_down/model/video_info.dart';
import 'package:bilivideo_down/provider/download_complete_provider.dart';
import 'package:bilivideo_down/util/common_util.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/range_download_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sp_util/sp_util.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

final downloadingProvider =
    StateNotifierProvider<DownloadingService, DownloadingState>((ref) {
  final downCompleteService = ref.watch(downloadCompleteProvider.notifier);
  return DownloadingService(downCompleteService);
});

class DownloadingService extends StateNotifier<DownloadingState> {
  final DownCompleteService downCompleteService;

  DownloadingService(this.downCompleteService)
      : super(DownloadingState(videoInfoList: []));

  void add(VideoInfo videoInfo) {
    state = state.copyWith(
      videoInfoList: [...state.videoInfoList, videoInfo],
    );
  }

  void addUnique(VideoInfo videoInfo) {
    if (!state.videoInfoList.any((e) => e.bvid == videoInfo.bvid)) {
      state = state.copyWith(
        videoInfoList: [...state.videoInfoList, videoInfo],
      );
      startDownload(videoInfo.bvid);
    }
  }

  bool exist(String bvid) {
    return state.videoInfoList.any((e) => e.bvid == bvid);
  }

  void removeAt(int index) {
    state = state.copyWith(
      videoInfoList: [
        ...state.videoInfoList..removeAt(index),
      ],
    );
  }

  void updateProgress(String bvid, double progress, String progressMsg) {
    final updatedList = state.videoInfoList.map((video) {
      if (video.bvid == bvid) {
        return video.copyWith(
          progress: progress,
          progressMsg: progressMsg,
        );
      }
      return video;
    }).toList();
    state = state.copyWith(videoInfoList: updatedList);
  }

  void updateDownStatus(String bvid, bool downStatus,
      {CancelToken? cancelToken}) {
    final updatedList = state.videoInfoList.map((video) {
      if (video.bvid == bvid) {
        return video.copyWith(downStatus: downStatus, cancelToken: cancelToken);
      }
      return video;
    }).toList();
    state = state.copyWith(videoInfoList: updatedList);
  }

  VideoInfo getVideoInfoByBvid(String bvid) {
    return state.videoInfoList.firstWhere((e) => e.bvid == bvid);
  }

  bool getVideoDownStatus(String bvid) {
    return state.videoInfoList.firstWhere((e) => e.bvid == bvid).downStatus;
  }

  double getProgress(String bvid) {
    return state.videoInfoList.firstWhere((e) => e.bvid == bvid).progress;
  }

  String getProgressMsg(String bvid) {
    return state.videoInfoList.firstWhere((e) => e.bvid == bvid).progressMsg;
  }

  Future<void> startDownload(String bvid) async {
    String storagePath = SpUtil.getString(SpKey.storagePath) ?? '';
    if (storagePath.isEmpty) {
      storagePath = (await getDownloadsDirectory())!.path;
      SpUtil.putString(SpKey.storagePath, storagePath);
    }
    VideoInfo video = getVideoInfoByBvid(bvid);

    final String url = video.playUrl;
    String currentDate =
        DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d);

    String savePath = path.join(storagePath, '下载合集_$currentDate');
    final String fileName = path.join(savePath, '${video.title}.mp4');
    final cancelToken = CancelToken();

    video = video.copyWith(location: savePath, cancelToken: cancelToken);
    updateDownStatus(bvid, true, cancelToken: cancelToken);
    downloadFile(url, fileName, video);
  }

  Future<void> downloadFile(
      String url, String savePath, VideoInfo video) async {
    try {
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
        final updatedList =
            state.videoInfoList.where((e) => e.bvid != video.bvid).toList();
        state = state.copyWith(videoInfoList: updatedList);
        downCompleteService.addVideo(video);
      }).catchError((error) {
        LogUtil.e('下载失败: $error');
      });
    } catch (e) {
      LogUtil.e("下载失败");
    }
  }
}
