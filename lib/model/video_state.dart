import 'package:bilivideo_down/entity/video_sec_entity.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'video_state.mapper.dart';

@MappableClass()
class VideoState with VideoStateMappable {
  //剧集列表
  final List<Episode> episodes;
  //加载状态
  final bool isLoading;
  final String? msg;

  VideoState({
    required this.episodes,
    required this.isLoading,
    this.msg,
  });
}
