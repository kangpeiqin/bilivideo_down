import 'package:bilivideo_down/model/video_info.dart';
import 'package:bilivideo_down/provider/downloading_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDownloader extends ConsumerStatefulWidget {
  final VideoInfo video;
  final VoidCallback onDelete;

  const VideoDownloader({
    super.key,
    required this.video,
    required this.onDelete,
  });

  @override
  ConsumerState<VideoDownloader> createState() => _VideoDownloaderState();
}

class _VideoDownloaderState extends ConsumerState<VideoDownloader> {
  @override
  Widget build(BuildContext context) {
    final downloadingService = ref.read(downloadingProvider.notifier);
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
                      image: NetworkImage(widget.video.pic),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            widget.video.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          downloadingService.getProgressMsg(widget.video.bvid),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value:
                              downloadingService.getProgress(widget.video.bvid),
                          minHeight: 10,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
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
              icon: Icon(
                downloadingService.getVideoDownStatus(widget.video.bvid)
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 20,
              ),
              onPressed: () {
                if (downloadingService.getVideoDownStatus(widget.video.bvid)) {
                  CancelToken cancelToken = downloadingService
                      .getVideoInfoByBvid(widget.video.bvid)
                      .cancelToken;
                  cancelToken.cancel();
                  downloadingService.updateDownStatus(widget.video.bvid, false);
                } else {
                  downloadingService.startDownload(widget.video.bvid);
                }
              },
              tooltip: downloadingService.getVideoDownStatus(widget.video.bvid)
                  ? '暂停'
                  : '开始',
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                downloadingService
                    .getVideoInfoByBvid(widget.video.bvid)
                    .cancelToken
                    .cancel();
                widget.onDelete();
              },
              tooltip: '删除视频',
            ),
          ),
        ],
      ),
    );
  }
}
