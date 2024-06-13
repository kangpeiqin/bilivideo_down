import 'package:bilivideo_down/controller/downloading_controller.dart';
import 'package:bilivideo_down/views/widget/video_downloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DownloadingPage extends StatefulWidget {
  const DownloadingPage({super.key});

  @override
  State<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends State<DownloadingPage> {
  var downController = Get.find<DownloadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: downController.videoInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                int reversedIndex =
                    downController.videoInfoList.length - 1 - index;
                return Obx(() {
                  if (reversedIndex < downController.videoInfoList.length) {
                    return VideoDownloader(
                      video: downController.videoInfoList[reversedIndex],
                      onDelete: () {
                        downController.removeAt(reversedIndex);
                      },
                    );
                  } else {
                    return Container();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
