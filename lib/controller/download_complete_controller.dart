import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:bilivideo_down/storage/dao/video_info_dao.dart';
import 'package:bilivideo_down/storage/flutter_db_storage.dart';
import 'package:get/get.dart';

class DownloadCompleteController extends GetxController {
  final VideoInfoDao infoDao = FlutterDbStorage.instance.videoInfoDao;
  final RxList<VideoInfoEntity> videoList = <VideoInfoEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshVideoList();
  }

  void addVideo(VideoInfoEntity video) async {
    bool exist = videoList.any((element) => element.bvid == video.bvid);
    if (!exist) {
      await infoDao.insert(video);
      refreshVideoList();
    }
  }

  void refreshVideoList() async {
    final videos = await infoDao.queryAll();
    videoList.assignAll(videos);
  }

  Future<void> deleteVideo(String bvid) async {
    await infoDao.deleteByBvid(bvid);
    refreshVideoList();
  }
}
