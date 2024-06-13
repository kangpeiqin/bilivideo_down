import 'package:bilivideo_down/controller/bili_video_search_controller.dart';
import 'package:bilivideo_down/controller/download_complete_controller.dart';
import 'package:bilivideo_down/controller/downloading_controller.dart';
import 'package:bilivideo_down/controller/wait_download_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiliVideoSearchController());
    Get.lazyPut(() => WaitDownloadController());
    Get.lazyPut(() => DownloadingController());
    Get.lazyPut(() => DownloadCompleteController());
  }
}
