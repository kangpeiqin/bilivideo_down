import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:get/get.dart';

class WaitDownloadController extends GetxController {
  var videoInfoList = <VideoInfoEntity>[].obs;

  void add(VideoInfoEntity entity) {
    videoInfoList.add(entity);
  }

  bool exist(String bvid) {
    return videoInfoList.any((e) => e.bvid == bvid);
  }

  void removeAt(int index) {
    videoInfoList.removeAt(index);
  }
}
