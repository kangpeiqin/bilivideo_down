import 'package:bilivideo_down/entity/video_info_entity.dart';
import 'package:bilivideo_down/util/common_util.dart';
import 'package:bilivideo_down/views/widget/video_palyer_ui.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoInfoEntity video;
  final VoidCallback onDelete;
  final VoidCallback onDownload;

  const VideoCard({
    super.key,
    required this.video,
    required this.onDelete,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(video.pubdate * 1000);
    String formattedDate =
        DateUtil.formatDate(date, format: DateFormats.y_mo_d);
    String description = video.desc.replaceAll('\n', ' ');
    String displayText = description.isEmpty ? video.title : description;
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
                  return VideoPlayerUI(videoUrl: video.playUrl);
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
                      image: NetworkImage(video.pic),
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
                            video.title,
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
                          "发布时间：$formattedDate   视频大小：${CommonUtil.formatBytes(video.size)}  播放时长：${CommonUtil.transferDuration(video.duration)}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "简介：$displayText",
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
              icon: const Icon(Icons.download, size: 20),
              onPressed: onDownload,
              tooltip: '下载视频',
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: onDelete,
              tooltip: '删除视频',
            ),
          ),
        ],
      ),
    );
  }
}
