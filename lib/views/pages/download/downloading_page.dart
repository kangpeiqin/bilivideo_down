import 'package:bilivideo_down/constant/constant.dart';
import 'package:bilivideo_down/provider/downloading_provider.dart';
import 'package:bilivideo_down/views/widget/video_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadingPage extends ConsumerStatefulWidget {
  const DownloadingPage({super.key});

  @override
  ConsumerState<DownloadingPage> createState() => _DownloadingPageState();
}

class _DownloadingPageState extends ConsumerState<DownloadingPage> {
  @override
  Widget build(BuildContext context) {
    final downloadingState = ref.watch(downloadingProvider);
    final downloadingService = ref.read(downloadingProvider.notifier);
    return Scaffold(
      body: downloadingState.videoInfoList.isEmpty
          ? Center(
              child: SizedBox(
                child: Image.asset('${Constant.baseAssetPath}/emp.png'),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: downloadingState.videoInfoList.length,
                    itemBuilder: (BuildContext context, int index) {
                      int reversedIndex =
                          downloadingState.videoInfoList.length - 1 - index;

                      if (reversedIndex <
                          downloadingState.videoInfoList.length) {
                        return VideoDownloader(
                          video: downloadingState.videoInfoList[reversedIndex],
                          onDelete: () {
                            downloadingService.removeAt(reversedIndex);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
