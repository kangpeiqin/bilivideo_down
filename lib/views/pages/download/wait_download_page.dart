import 'dart:io';

import 'package:bilivideo_down/constant/sp_key.dart';
import 'package:bilivideo_down/provider/downloading_provider.dart';
import 'package:bilivideo_down/provider/wait_download_provider.dart';
import 'package:bilivideo_down/views/nav/download_nav.dart';
import 'package:bilivideo_down/views/widget/video_card_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sp_util/sp_util.dart';

class WaitDownloadPage extends ConsumerStatefulWidget {
  const WaitDownloadPage({super.key});

  @override
  ConsumerState<WaitDownloadPage> createState() => _WaitDownloadPageState();
}

class _WaitDownloadPageState extends ConsumerState<WaitDownloadPage> {
  @override
  Widget build(BuildContext context) {
    final waitDownloadState = ref.watch(waitDownloadProvider);
    final downloadService = ref.read(waitDownloadProvider.notifier);
    final downloadingService = ref.read(downloadingProvider.notifier);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: waitDownloadState.videoInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                int reversedIndex =
                    waitDownloadState.videoInfoList.length - 1 - index;

                return VideoCardWidget(
                  video: waitDownloadState.videoInfoList[reversedIndex],
                  onDelete: () {
                    downloadService.removeAt(reversedIndex);
                    setState(() {});
                  },
                  onDownload: () async {
                    if (Platform.isMacOS) {
                      bool accessStatus = await handlePathSelection(context);
                      if (accessStatus == false) {
                        return;
                      }
                    }

                    downloadingService.addUnique(
                        waitDownloadState.videoInfoList[reversedIndex]);
                    final downloadNavigationState = context
                        .findAncestorStateOfType<DownloadTabsPageState>();
                    downloadNavigationState?.navigateToTab(1);
                    downloadService.removeAt(reversedIndex);
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

Future<bool> handlePathSelection(BuildContext context) async {
  String? storagePath = SpUtil.getString(SpKey.storagePath);

  if (storagePath == null ||
      storagePath.isEmpty ||
      !(await checkDirectoryAccess(storagePath))) {
    final selectedPath = await FilePicker.platform.getDirectoryPath();

    if (selectedPath != null) {
      SpUtil.putString(SpKey.storagePath, selectedPath);
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          showAccessDialog(context, '下载路径选择', '请选择下载路径');
        }
      });
      return false;
    }
  }
  return true;
}

Future<bool> checkDirectoryAccess(String path) async {
  final directory = Directory(path);

  if (!await directory.exists()) {
    return false;
  }

  try {
    final testFile = File('${directory.path}/.test_permission');
    await testFile.writeAsString('test');
    await testFile.delete();
    return true;
  } catch (e) {
    return false;
  }
}

void showAccessDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      );
    },
  );
}
