import 'dart:convert';

VideoSecEntity videoSecEntityFromJson(String str) =>
    VideoSecEntity.fromJson(json.decode(str));

String videoSecEntityToJson(VideoSecEntity data) => json.encode(data.toJson());

class VideoSecEntity {
  String bvid;
  int aid;
  String pic;
  String title;
  int pubdate;
  int ctime;
  String desc;
  String videoSecEntityDynamic;
  int cid;
  int? seasonId;
  UgcSeason? ugcSeason;
  List<Page>? pages;

  VideoSecEntity({
    required this.bvid,
    required this.aid,
    required this.pic,
    required this.title,
    required this.pubdate,
    required this.ctime,
    required this.desc,
    required this.videoSecEntityDynamic,
    required this.cid,
    required this.seasonId,
    required this.ugcSeason,
    this.pages,
  });

  factory VideoSecEntity.fromJson(Map<String, dynamic> json) => VideoSecEntity(
        bvid: json["bvid"],
        aid: json["aid"],
        pic: json["pic"],
        title: json["title"],
        pubdate: json["pubdate"],
        ctime: json["ctime"],
        desc: json["desc"],
        videoSecEntityDynamic: json["dynamic"],
        cid: json["cid"],
        seasonId: json["season_id"],
        ugcSeason: json["ugc_season"] != null
            ? UgcSeason.fromJson(json["ugc_season"])
            : null,
        pages: json["pages"] != null
            ? List<Page>.from(json["pages"].map((x) => Page.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "bvid": bvid,
        "aid": aid,
        "pic": pic,
        "title": title,
        "pubdate": pubdate,
        "ctime": ctime,
        "desc": desc,
        "dynamic": videoSecEntityDynamic,
        "cid": cid,
        "season_id": seasonId,
        "ugc_season": ugcSeason?.toJson(),
      };
}

class UgcSeason {
  int id;
  String title;
  String cover;
  int mid;
  String intro;
  int signState;
  int attribute;
  List<Section> sections;
  int epCount;

  UgcSeason({
    required this.id,
    required this.title,
    required this.cover,
    required this.mid,
    required this.intro,
    required this.signState,
    required this.attribute,
    required this.sections,
    required this.epCount,
  });

  factory UgcSeason.fromJson(Map<String, dynamic> json) => UgcSeason(
        id: json["id"],
        title: json["title"],
        cover: json["cover"],
        mid: json["mid"],
        intro: json["intro"],
        signState: json["sign_state"],
        attribute: json["attribute"],
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
        epCount: json["ep_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover": cover,
        "mid": mid,
        "intro": intro,
        "sign_state": signState,
        "attribute": attribute,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "ep_count": epCount,
      };
}

class Section {
  int seasonId;
  List<Episode> episodes;

  Section({
    required this.seasonId,
    required this.episodes,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        seasonId: json["season_id"],
        episodes: List<Episode>.from(
            json["episodes"].map((x) => Episode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "season_id": seasonId,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };
}

class Episode {
  int aid;
  int cid;
  String title;
  String bvid;
  Arc arc;
  late bool checked;

  Episode({
    required this.aid,
    required this.cid,
    required this.title,
    required this.bvid,
    required this.arc,
    this.checked = false,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        aid: json["aid"],
        cid: json["cid"],
        title: json["title"],
        bvid: json["bvid"],
        arc: Arc.fromJson(json['arc']),
      );

  Map<String, dynamic> toJson() => {
        "aid": aid,
        "cid": cid,
        "title": title,
        "bvid": bvid,
        "arc": arc.toJson()
      };
}

class Arc {
  String pic;
  int pubdate;
  int ctime;
  Arc({
    required this.pic,
    required this.pubdate,
    required this.ctime,
  });

  factory Arc.fromJson(Map<String, dynamic> json) => Arc(
        pic: json["pic"],
        pubdate: json["pubdate"],
        ctime: json["ctime"],
      );

  Map<String, dynamic> toJson() => {
        "pic": pic,
        "pubdate": pubdate,
        "ctime": ctime,
      };
}

class Page {
  int cid;
  int page;
  String from;
  String pagePart;
  int duration;
  String vid;
  String weblink;
  String firstFrame;

  Page({
    required this.cid,
    required this.page,
    required this.from,
    required this.pagePart,
    required this.duration,
    required this.vid,
    required this.weblink,
    required this.firstFrame,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        cid: json["cid"],
        page: json["page"],
        from: json["from"],
        pagePart: json["part"],
        duration: json["duration"],
        vid: json["vid"],
        weblink: json["weblink"],
        firstFrame: json["first_frame"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "page": page,
        "from": from,
        "part": pagePart,
        "duration": duration,
        "vid": vid,
        "weblink": weblink,
        "first_frame": firstFrame,
      };
}
