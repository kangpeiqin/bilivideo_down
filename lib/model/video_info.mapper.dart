// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'video_info.dart';

class VideoInfoMapper extends ClassMapperBase<VideoInfo> {
  VideoInfoMapper._();

  static VideoInfoMapper? _instance;
  static VideoInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VideoInfo';

  static String _$bvid(VideoInfo v) => v.bvid;
  static const Field<VideoInfo, String> _f$bvid = Field('bvid', _$bvid);
  static int _$aid(VideoInfo v) => v.aid;
  static const Field<VideoInfo, int> _f$aid = Field('aid', _$aid);
  static int _$cid(VideoInfo v) => v.cid;
  static const Field<VideoInfo, int> _f$cid = Field('cid', _$cid);
  static String _$pic(VideoInfo v) => v.pic;
  static const Field<VideoInfo, String> _f$pic = Field('pic', _$pic);
  static String _$title(VideoInfo v) => v.title;
  static const Field<VideoInfo, String> _f$title = Field('title', _$title);
  static int _$pubdate(VideoInfo v) => v.pubdate;
  static const Field<VideoInfo, int> _f$pubdate = Field('pubdate', _$pubdate);
  static int _$ctime(VideoInfo v) => v.ctime;
  static const Field<VideoInfo, int> _f$ctime = Field('ctime', _$ctime);
  static String _$desc(VideoInfo v) => v.desc;
  static const Field<VideoInfo, String> _f$desc = Field('desc', _$desc);
  static int _$duration(VideoInfo v) => v.duration;
  static const Field<VideoInfo, int> _f$duration =
      Field('duration', _$duration);
  static int _$downloadStatus(VideoInfo v) => v.downloadStatus;
  static const Field<VideoInfo, int> _f$downloadStatus =
      Field('downloadStatus', _$downloadStatus, opt: true, def: 0);
  static String _$playUrl(VideoInfo v) => v.playUrl;
  static const Field<VideoInfo, String> _f$playUrl =
      Field('playUrl', _$playUrl, opt: true, def: '');
  static int _$length(VideoInfo v) => v.length;
  static const Field<VideoInfo, int> _f$length =
      Field('length', _$length, opt: true, def: 0);
  static int _$size(VideoInfo v) => v.size;
  static const Field<VideoInfo, int> _f$size =
      Field('size', _$size, opt: true, def: 0);
  static double _$progress(VideoInfo v) => v.progress;
  static const Field<VideoInfo, double> _f$progress =
      Field('progress', _$progress, opt: true, def: 0);
  static String _$progressMsg(VideoInfo v) => v.progressMsg;
  static const Field<VideoInfo, String> _f$progressMsg =
      Field('progressMsg', _$progressMsg, opt: true, def: '');
  static bool _$downStatus(VideoInfo v) => v.downStatus;
  static const Field<VideoInfo, bool> _f$downStatus =
      Field('downStatus', _$downStatus, opt: true, def: false);
  static String _$location(VideoInfo v) => v.location;
  static const Field<VideoInfo, String> _f$location =
      Field('location', _$location, opt: true, def: '');
  static CancelToken _$cancelToken(VideoInfo v) => v.cancelToken;
  static const Field<VideoInfo, CancelToken> _f$cancelToken =
      Field('cancelToken', _$cancelToken, mode: FieldMode.member);

  @override
  final MappableFields<VideoInfo> fields = const {
    #bvid: _f$bvid,
    #aid: _f$aid,
    #cid: _f$cid,
    #pic: _f$pic,
    #title: _f$title,
    #pubdate: _f$pubdate,
    #ctime: _f$ctime,
    #desc: _f$desc,
    #duration: _f$duration,
    #downloadStatus: _f$downloadStatus,
    #playUrl: _f$playUrl,
    #length: _f$length,
    #size: _f$size,
    #progress: _f$progress,
    #progressMsg: _f$progressMsg,
    #downStatus: _f$downStatus,
    #location: _f$location,
    #cancelToken: _f$cancelToken,
  };

  static VideoInfo _instantiate(DecodingData data) {
    return VideoInfo(
        bvid: data.dec(_f$bvid),
        aid: data.dec(_f$aid),
        cid: data.dec(_f$cid),
        pic: data.dec(_f$pic),
        title: data.dec(_f$title),
        pubdate: data.dec(_f$pubdate),
        ctime: data.dec(_f$ctime),
        desc: data.dec(_f$desc),
        duration: data.dec(_f$duration),
        downloadStatus: data.dec(_f$downloadStatus),
        playUrl: data.dec(_f$playUrl),
        length: data.dec(_f$length),
        size: data.dec(_f$size),
        progress: data.dec(_f$progress),
        progressMsg: data.dec(_f$progressMsg),
        downStatus: data.dec(_f$downStatus),
        location: data.dec(_f$location));
  }

  @override
  final Function instantiate = _instantiate;

  static VideoInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VideoInfo>(map);
  }

  static VideoInfo fromJson(String json) {
    return ensureInitialized().decodeJson<VideoInfo>(json);
  }
}

mixin VideoInfoMappable {
  String toJson() {
    return VideoInfoMapper.ensureInitialized()
        .encodeJson<VideoInfo>(this as VideoInfo);
  }

  Map<String, dynamic> toMap() {
    return VideoInfoMapper.ensureInitialized()
        .encodeMap<VideoInfo>(this as VideoInfo);
  }

  VideoInfoCopyWith<VideoInfo, VideoInfo, VideoInfo> get copyWith =>
      _VideoInfoCopyWithImpl(this as VideoInfo, $identity, $identity);
  @override
  String toString() {
    return VideoInfoMapper.ensureInitialized()
        .stringifyValue(this as VideoInfo);
  }

  @override
  bool operator ==(Object other) {
    return VideoInfoMapper.ensureInitialized()
        .equalsValue(this as VideoInfo, other);
  }

  @override
  int get hashCode {
    return VideoInfoMapper.ensureInitialized().hashValue(this as VideoInfo);
  }
}

extension VideoInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, VideoInfo, $Out> {
  VideoInfoCopyWith<$R, VideoInfo, $Out> get $asVideoInfo =>
      $base.as((v, t, t2) => _VideoInfoCopyWithImpl(v, t, t2));
}

abstract class VideoInfoCopyWith<$R, $In extends VideoInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? bvid,
      int? aid,
      int? cid,
      String? pic,
      String? title,
      int? pubdate,
      int? ctime,
      String? desc,
      int? duration,
      int? downloadStatus,
      String? playUrl,
      int? length,
      int? size,
      double? progress,
      String? progressMsg,
      bool? downStatus,
      String? location});
  VideoInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VideoInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VideoInfo, $Out>
    implements VideoInfoCopyWith<$R, VideoInfo, $Out> {
  _VideoInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VideoInfo> $mapper =
      VideoInfoMapper.ensureInitialized();
  @override
  $R call(
          {String? bvid,
          int? aid,
          int? cid,
          String? pic,
          String? title,
          int? pubdate,
          int? ctime,
          String? desc,
          int? duration,
          int? downloadStatus,
          String? playUrl,
          int? length,
          int? size,
          double? progress,
          String? progressMsg,
          bool? downStatus,
          String? location}) =>
      $apply(FieldCopyWithData({
        if (bvid != null) #bvid: bvid,
        if (aid != null) #aid: aid,
        if (cid != null) #cid: cid,
        if (pic != null) #pic: pic,
        if (title != null) #title: title,
        if (pubdate != null) #pubdate: pubdate,
        if (ctime != null) #ctime: ctime,
        if (desc != null) #desc: desc,
        if (duration != null) #duration: duration,
        if (downloadStatus != null) #downloadStatus: downloadStatus,
        if (playUrl != null) #playUrl: playUrl,
        if (length != null) #length: length,
        if (size != null) #size: size,
        if (progress != null) #progress: progress,
        if (progressMsg != null) #progressMsg: progressMsg,
        if (downStatus != null) #downStatus: downStatus,
        if (location != null) #location: location
      }));
  @override
  VideoInfo $make(CopyWithData data) => VideoInfo(
      bvid: data.get(#bvid, or: $value.bvid),
      aid: data.get(#aid, or: $value.aid),
      cid: data.get(#cid, or: $value.cid),
      pic: data.get(#pic, or: $value.pic),
      title: data.get(#title, or: $value.title),
      pubdate: data.get(#pubdate, or: $value.pubdate),
      ctime: data.get(#ctime, or: $value.ctime),
      desc: data.get(#desc, or: $value.desc),
      duration: data.get(#duration, or: $value.duration),
      downloadStatus: data.get(#downloadStatus, or: $value.downloadStatus),
      playUrl: data.get(#playUrl, or: $value.playUrl),
      length: data.get(#length, or: $value.length),
      size: data.get(#size, or: $value.size),
      progress: data.get(#progress, or: $value.progress),
      progressMsg: data.get(#progressMsg, or: $value.progressMsg),
      downStatus: data.get(#downStatus, or: $value.downStatus),
      location: data.get(#location, or: $value.location));

  @override
  VideoInfoCopyWith<$R2, VideoInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VideoInfoCopyWithImpl($value, $cast, t);
}
