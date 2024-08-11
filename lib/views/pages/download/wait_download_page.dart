import 'package:bilivideo_down/provider/downloading_provider.dart';
import 'package:bilivideo_down/provider/wait_download_provider.dart';
import 'package:bilivideo_down/views/nav/download_nav.dart';
import 'package:bilivideo_down/views/widget/video_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  onDownload: () {
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
