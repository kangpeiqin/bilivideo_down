import 'package:bilivideo_down/model/video_info.dart';
import 'package:bilivideo_down/storage/dao/video_info_dao.dart';
import 'package:bilivideo_down/storage/flutter_db_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final downloadCompleteProvider =
    StateNotifierProvider<DownCompleteService, List<VideoInfo>>((ref) {
  final videoInfoDao = ref.read(videoInfoDaoProvider);
  return DownCompleteService(videoInfoDao);
});

final videoInfoDaoProvider = Provider<VideoInfoDao>((ref) {
  return FlutterDbStorage.instance.videoInfoDao;
});

class DownCompleteService extends StateNotifier<List<VideoInfo>> {
  final VideoInfoDao infoDao;

  DownCompleteService(this.infoDao) : super([]) {
    refreshVideoList();
  }

  Future<void> addVideo(VideoInfo video) async {
    if (state.any((element) => element.bvid == video.bvid)) return;
    await infoDao.insert(video);
    refreshVideoList();
  }

  Future<void> deleteVideo(String bvid) async {
    await infoDao.deleteByBvid(bvid);
    refreshVideoList();
  }

  Future<void> refreshVideoList() async {
    final videos = await infoDao.queryAll();
    state = videos;
  }
}
