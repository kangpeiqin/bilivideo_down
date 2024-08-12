import 'dart:io';

import 'package:bilivideo_down/provider/download_complete_provider.dart';
import 'package:bilivideo_down/util/common_util.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDownCompletePage extends ConsumerWidget {
  const VideoDownCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.watch() 确保 UI 能响应状态的变化，并自动刷新
    var completeState = ref.watch(downloadCompleteProvider);
    final completeService = ref.read(downloadCompleteProvider.notifier);

    return Scaffold(
      body: ListView.builder(
        itemCount: completeState.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                InkWell(
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
                            image: NetworkImage(completeState[index].pic),
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
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  completeState[index].title,
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
                                "视频大小：${CommonUtil.formatBytes(completeState[index].size)}  播放时长：${CommonUtil.transferDuration(completeState[index].duration)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "简介：${completeState[index].title}",
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
                    onPressed: () async {
                      final success =
                          await openDirectory(completeState[index].location);
                      if (!success) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (context.mounted) {
                            showErrorDialog(context);
                          }
                        });
                      }
                    },
                    tooltip: '打开文件夹',
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      completeService.deleteVideo(completeState[index].bvid);
                    },
                    tooltip: '删除视频',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<bool> openDirectory(String storePath) async {
  try {
    if (Directory(storePath).existsSync()) {
      if (Platform.isWindows) {
        await Process.run('explorer', [storePath]);
      } else if (Platform.isMacOS) {
        await Process.run('open', [storePath]);
      }
      return true; // Directory opened successfully
    } else {
      return false; // Directory does not exist
    }
  } catch (e) {
    Log.e("Error opening directory: $e"); // Log the error
    return false; // Failed to open directory
  }
}

void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('打开文件夹失败'),
      content: const Text('文件夹已被删除，无法打开指定的文件夹'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('确定'),
        ),
      ],
    ),
  );
}
