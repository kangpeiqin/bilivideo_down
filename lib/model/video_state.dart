import 'package:bilivideo_down/entity/video_sec_entity.dart';

class VideoState {
  //剧集列表
  final List<Episode> episodes;
  final bool isLoading;
  final String? error;

  VideoState({
    required this.episodes,
    required this.isLoading,
    this.error,
  });
}
