import 'package:bilivideo_down/model/video_info.dart';
import 'package:dart_mappable/dart_mappable.dart';
part 'downloading_state.mapper.dart';

@MappableClass()
class DownloadingState with DownloadingStateMappable {
  final List<VideoInfo> videoInfoList;

  DownloadingState({required this.videoInfoList});
}
