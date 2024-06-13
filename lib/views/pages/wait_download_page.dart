import 'package:bilivideo_down/controller/downloading_controller.dart';
import 'package:bilivideo_down/controller/wait_download_controller.dart';
import 'package:bilivideo_down/views/nav/download_nav.dart';
import 'package:bilivideo_down/views/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitDownloadPage extends StatefulWidget {
  const WaitDownloadPage({super.key});

  @override
  State<WaitDownloadPage> createState() => _WaitDownloadPageState();
}

class _WaitDownloadPageState extends State<WaitDownloadPage> {
  var waitDownController = Get.find<WaitDownloadController>();
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
              itemCount: waitDownController.videoInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                int reversedIndex =
                    waitDownController.videoInfoList.length - 1 - index;

                return VideoCard(
                  video: waitDownController.videoInfoList[reversedIndex],
                  onDelete: () {
                    waitDownController.removeAt(reversedIndex);
                    setState(() {});
                  },
                  onDownload: () {
                    downController.addUnique(
                        waitDownController.videoInfoList[reversedIndex]);
                    final downloadNavigationState = context
                        .findAncestorStateOfType<DownloadTabsPageState>();
                    downloadNavigationState?.navigateToTab(1);
                    waitDownController.removeAt(reversedIndex);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
