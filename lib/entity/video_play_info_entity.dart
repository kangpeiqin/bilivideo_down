import 'dart:convert';

VideoPlayInfoEntity videoPlayInfoEntityFromJson(String str) =>
    VideoPlayInfoEntity.fromJson(json.decode(str));

String videoPlayInfoEntityToJson(VideoPlayInfoEntity data) =>
    json.encode(data.toJson());

class VideoPlayInfoEntity {
  int quality;
  String format;
  int timelength;
  String acceptFormat;
  List<Durl> durl;

  VideoPlayInfoEntity({
    required this.quality,
    required this.format,
    required this.timelength,
    required this.acceptFormat,
    required this.durl,
  });

  factory VideoPlayInfoEntity.fromJson(Map<String, dynamic> json) =>
      VideoPlayInfoEntity(
        quality: json["quality"],
        format: json["format"],
        timelength: json["timelength"],
        acceptFormat: json["accept_format"],
        durl: List<Durl>.from(json["durl"].map((x) => Durl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quality": quality,
        "format": format,
        "timelength": timelength,
        "accept_format": acceptFormat,
        "durl": List<dynamic>.from(durl.map((x) => x.toJson())),
      };
}

class Durl {
  int length;
  int size;
  String url;

  Durl({
    required this.length,
    required this.size,
    required this.url,
  });

  factory Durl.fromJson(Map<String, dynamic> json) => Durl(
        length: json["length"],
        size: json["size"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "size": size,
        "url": url,
      };
}
