import 'package:bilivideo_down/controller/downloading_controller.dart';
import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoDownloader extends StatefulWidget {
  final VideoInfoEntity video;
  final VoidCallback onDelete;

  const VideoDownloader({
    super.key,
    required this.video,
    required this.onDelete,
  });

  @override
  State<VideoDownloader> createState() => _VideoDownloaderState();
}

class _VideoDownloaderState extends State<VideoDownloader> {
  var downController = Get.find<DownloadingController>();

  Future<void> _toggleDownload() async {
    if (downController.getVideoDownStatus(widget.video.bvid)) {
      downController.getVideoInfoByBvid(widget.video.bvid).cancelToken.cancel();
      downController.updateDownStatus(widget.video.bvid, false);
    } else {
      downController.startDownload(widget.video.bvid);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          downController.getProgressMsg(widget.video.bvid),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: downController.getProgress(widget.video.bvid),
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
                downController.getVideoDownStatus(widget.video.bvid)
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 20,
              ),
              onPressed: _toggleDownload,
              tooltip: downController.getVideoDownStatus(widget.video.bvid)
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
                downController
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
