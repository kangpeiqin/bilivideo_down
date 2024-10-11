import 'package:bilivideo_down/constant/http_api.dart';
import 'package:bilivideo_down/entity/video_play_info_entity.dart';
import 'package:bilivideo_down/entity/video_sec_entity.dart';
import 'package:bilivideo_down/model/video_info.dart';
import 'package:bilivideo_down/model/video_state.dart';
import 'package:bilivideo_down/provider/wait_download_provider.dart';
import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/util/dio_util.dart';
import 'package:bilivideo_down/util/log_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoSearchProvider =
    StateNotifierProvider<VideoSearchService, VideoState>((ref) {
  final controller = ref.read(searchControllerProvider);
  final downloadStateService = ref.read(waitDownloadProvider.notifier);
  return VideoSearchService(controller, downloadStateService);
});

final searchControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class VideoSearchService extends StateNotifier<VideoState> {
  final TextEditingController controller;
  final WaitDownloadService downloadStateService;

  VideoSearchService(this.controller, this.downloadStateService)
      : super(VideoState(isLoading: false, episodes: []));

  Future<void> handleSearch(String input) async {
    final RegExp regExp = RegExp(r'BV[\w]+');
    final match = regExp.firstMatch(input);
    if (match != null) {
      state =
          state.copyWith(episodes: state.episodes, isLoading: true, msg: null);
      await fetchVideoInfo(match.group(0)!);
    } else {
      state = state.copyWith(
          episodes: state.episodes, isLoading: false, msg: "错误的B站视频链接");
    }
  }

  Future<void> fetchVideoInfo(String bv) async {
    try {
      await DioUtil.instance.requestNetwork<VideoSecEntity>(
        Method.get,
        HttpApi.biliBiliViewUrl,
        queryParameters: {'bvid': bv},
        onSuccess: (data) async {
          if (data != null) {
            final ugcSeason = data.ugcSeason;
            if (ugcSeason != null) {
              final List<Episode> episodes = ugcSeason.sections[0].episodes;
              state = state.copyWith(episodes: episodes, isLoading: false);
            } else if (data.pages?.isNotEmpty ?? false) {
              List<Episode> episodes = [];
              data.pages?.forEach((element) {
                Episode episode = Episode(
                    aid: data.aid,
                    cid: element.cid,
                    title: element.pagePart,
                    bvid: '$bv+${element.cid}',
                    arc: Arc(
                        pic: element.firstFrame,
                        pubdate: data.pubdate,
                        ctime: data.ctime));
                episodes.add(episode);
                // Log.d('${episode.toJson()}');
              });
              state = state.copyWith(episodes: episodes, isLoading: false);
            } else {
              try {
                //获取下载链接
                await DioUtil.instance.requestNetwork<VideoPlayInfoEntity>(
                    Method.get, HttpApi.biliBiliVideoPlayUrl,
                    queryParameters: {
                      'avid': data.aid,
                      'cid': data.cid,
                      'qn': 80,
                      'platform': 'html5',
                      'otype': 'json',
                      'high_quality': 1
                    }, onSuccess: (infoData) async {
                  if (infoData != null) {
                    bool exist = downloadStateService.exist(data.bvid);
                    if (!exist) {
                      Durl durl = infoData.durl[0];
                      VideoInfo infoEntity = VideoInfo(
                          bvid: data.bvid,
                          aid: data.aid,
                          cid: data.cid,
                          pic: data.pic,
                          title: data.title,
                          pubdate: data.pubdate,
                          ctime: data.ctime,
                          desc: "",
                          duration: durl.length,
                          playUrl: durl.url,
                          size: durl.size);
                      downloadStateService.add(infoEntity);
                    }
                  }
                }, onError: (code, msg) {
                  debugPrint('$code, $msg');
                });
                state = state.copyWith(episodes: [], isLoading: false);
                routerConfig.replace(RouterPath.download);
              } catch (e) {
                Log.e(e.toString());
              }
            }
          }
        },
        onError: (code, msg) => {
          state = state.copyWith(
              episodes: state.episodes, isLoading: false, msg: msg)
        },
      );
    } catch (e) {
      state = VideoState(
          episodes: state.episodes, isLoading: false, msg: e.toString());
    }
  }
}
