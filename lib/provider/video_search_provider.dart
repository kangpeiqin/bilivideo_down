import 'package:bilivideo_down/constant/http_api.dart';
import 'package:bilivideo_down/entity/video_sec_entity.dart';
import 'package:bilivideo_down/model/video_state.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoSearchProvider =
    StateNotifierProvider<VideoSearchService, VideoState>((ref) {
  final searchService = VideoSearchService();
  return searchService;
});

class VideoSearchService extends StateNotifier<VideoState> {
  VideoSearchService() : super(VideoState(isLoading: false, episodes: []));

  Future<void> handleSearch(String input) async {
    final RegExp regExp = RegExp(r'BV[\w]+');
    final match = regExp.firstMatch(input);

    if (match != null) {
      state = VideoState(episodes: state.episodes, isLoading: true);
      try {
        await fetchVideoInfo(match.group(0)!);
      } catch (e) {
        state = VideoState(
            episodes: state.episodes, isLoading: false, error: e.toString());
      }
    } else {
      state = VideoState(
          episodes: state.episodes, isLoading: false, error: "错误的B站视频链接");
    }
  }

  Future<void> fetchVideoInfo(String bv) async {
    try {
      final data = await DioUtil.instance.requestNetwork<VideoSecEntity>(
        Method.get,
        HttpApi.biliBiliViewUrl,
        queryParameters: {'bvid': bv},
      );
      print(data);
      if (data != null) {
        final List<Episode> episodes =
            data.ugcSeason?.sections[0].episodes ?? [];
        state = VideoState(episodes: episodes, isLoading: false);
      }
    } catch (e) {
      state = VideoState(
          episodes: state.episodes, isLoading: false, error: e.toString());
    }
  }
}
