import 'package:dio/dio.dart';

class VideoInfoEntity {
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

  VideoInfoEntity({
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

  factory VideoInfoEntity.fromJson(Map<String, dynamic> json) =>
      VideoInfoEntity(
        bvid: json["bvid"],
        aid: json["aid"],
        cid: json["cid"],
        pic: json["pic"],
        title: json["title"],
        pubdate: json["pubdate"],
        ctime: json["ctime"],
        desc: json["desc"],
        duration: json["duration"],
        playUrl: json['playUrl'],
        length: json['length'],
        size: json['size'],
        location: json['location'],
      );

  Map<String, dynamic> toJson() => {
        "bvid": bvid,
        "aid": aid,
        "cid": cid,
        "pic": pic,
        "title": title,
        "pubdate": pubdate,
        "ctime": ctime,
        "desc": desc,
        "duration": duration,
        "downloadSataus": downloadStatus,
        "playUrl": playUrl,
        "length": length,
        "size": size,
        "location": location,
      };
}
