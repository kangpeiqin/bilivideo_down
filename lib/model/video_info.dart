import 'package:dart_mappable/dart_mappable.dart';
import 'package:dio/dio.dart';
part 'video_info.mapper.dart';

@MappableClass()
class VideoInfo with VideoInfoMappable {
  late String bvid;
  late int aid;
  late int cid;
  late String pic;
  late String title;
  late int pubdate;
  late int ctime;
  late String desc;
  late int duration;
  late int downloadStatus;
  late String playUrl;
  late int length;
  late int size;
  late double progress;
  late String progressMsg;
  late bool downStatus;
  late CancelToken cancelToken;
  late String location;

  VideoInfo({
    required this.bvid,
    required this.aid,
    required this.cid,
    required this.pic,
    required this.title,
    required this.pubdate,
    required this.ctime,
    required this.desc,
    required this.duration,
    this.downloadStatus = 0,
    this.playUrl = '',
    this.length = 0,
    this.size = 0,
    this.progress = 0,
    this.progressMsg = '',
    this.downStatus = false,
    this.location = '',
  });
}
