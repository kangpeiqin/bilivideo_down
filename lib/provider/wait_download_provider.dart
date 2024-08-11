import 'package:bilivideo_down/model/downloading_state.dart';
import 'package:bilivideo_down/model/video_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final waitDownloadProvider =
    StateNotifierProvider<WaitDownloadService, DownloadingState>((ref) {
  return WaitDownloadService();
});

class WaitDownloadService extends StateNotifier<DownloadingState> {
  WaitDownloadService() : super(DownloadingState(videoInfoList: []));

  void add(VideoInfo entity) {
    state = state.copyWith(
      videoInfoList: [...state.videoInfoList, entity],
    );
  }

  bool exist(String bvid) {
    return state.videoInfoList.any((e) => e.bvid == bvid);
  }

  void removeAt(int index) {
    final updatedList = List<VideoInfo>.from(state.videoInfoList)
      ..removeAt(index);
    state = state.copyWith(videoInfoList: updatedList);
  }
}
