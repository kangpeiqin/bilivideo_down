import 'dart:io';

import 'package:bilivideo_down/controller/download_complete_controller.dart';
import 'package:bilivideo_down/util/common_util.dart';
import 'package:bilivideo_down/views/widget/video_palyer_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class VideoDownCompletePage extends StatelessWidget {
  const VideoDownCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DownloadCompleteController>();
    return Scaffold(
      body: Obx(() {
        final videoList = controller.videoList;
        return ListView.builder(
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return VideoPlayerUI(
                              videoUrl: videoList[index].playUrl);
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(videoList[index].pic),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    videoList[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "视频大小：${CommonUtil.formatBytes(videoList[index].size)}  播放时长：${CommonUtil.transferDuration(videoList[index].duration)}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "简介：${videoList[index].title}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 44,
                    top: 4,
                    child: IconButton(
                      icon: const Icon(Icons.folder, size: 20),
                      onPressed: () => openDirectory(videoList[index].location),
                      tooltip: '打开文件夹',
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        controller.deleteVideo(videoList[index].bvid);
                      },
                      tooltip: '删除视频',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

Future<void> openDirectory(String storePath) async {
  if (Directory(storePath).existsSync()) {
    if (Platform.isWindows) {
      await Process.run('explorer', [storePath]);
    } else if (Platform.isMacOS) {
      await Process.run('open', [storePath]);
    }
  }
}
