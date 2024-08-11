// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'video_state.dart';

class VideoStateMapper extends ClassMapperBase<VideoState> {
  VideoStateMapper._();

  static VideoStateMapper? _instance;
  static VideoStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VideoStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VideoState';

  static List<Episode> _$episodes(VideoState v) => v.episodes;
  static const Field<VideoState, List<Episode>> _f$episodes =
      Field('episodes', _$episodes);
  static bool _$isLoading(VideoState v) => v.isLoading;
  static const Field<VideoState, bool> _f$isLoading =
      Field('isLoading', _$isLoading);
  static String? _$msg(VideoState v) => v.msg;
  static const Field<VideoState, String> _f$msg =
      Field('msg', _$msg, opt: true);

  @override
  final MappableFields<VideoState> fields = const {
    #episodes: _f$episodes,
    #isLoading: _f$isLoading,
    #msg: _f$msg,
  };

  static VideoState _instantiate(DecodingData data) {
    return VideoState(
        episodes: data.dec(_f$episodes),
        isLoading: data.dec(_f$isLoading),
        msg: data.dec(_f$msg));
  }

  @override
  final Function instantiate = _instantiate;

  static VideoState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VideoState>(map);
  }

  static VideoState fromJson(String json) {
    return ensureInitialized().decodeJson<VideoState>(json);
  }
}

mixin VideoStateMappable {
  String toJson() {
    return VideoStateMapper.ensureInitialized()
        .encodeJson<VideoState>(this as VideoState);
  }

  Map<String, dynamic> toMap() {
    return VideoStateMapper.ensureInitialized()
        .encodeMap<VideoState>(this as VideoState);
  }

  VideoStateCopyWith<VideoState, VideoState, VideoState> get copyWith =>
      _VideoStateCopyWithImpl(this as VideoState, $identity, $identity);
  @override
  String toString() {
    return VideoStateMapper.ensureInitialized()
        .stringifyValue(this as VideoState);
  }

  @override
  bool operator ==(Object other) {
    return VideoStateMapper.ensureInitialized()
        .equalsValue(this as VideoState, other);
  }

  @override
  int get hashCode {
    return VideoStateMapper.ensureInitialized().hashValue(this as VideoState);
  }
}

extension VideoStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VideoState, $Out> {
  VideoStateCopyWith<$R, VideoState, $Out> get $asVideoState =>
      $base.as((v, t, t2) => _VideoStateCopyWithImpl(v, t, t2));
}

abstract class VideoStateCopyWith<$R, $In extends VideoState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Episode, ObjectCopyWith<$R, Episode, Episode>> get episodes;
  $R call({List<Episode>? episodes, bool? isLoading, String? msg});
  VideoStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _VideoStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VideoState, $Out>
    implements VideoStateCopyWith<$R, VideoState, $Out> {
  _VideoStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VideoState> $mapper =
      VideoStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Episode, ObjectCopyWith<$R, Episode, Episode>>
      get episodes => ListCopyWith($value.episodes,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(episodes: v));
  @override
  $R call({List<Episode>? episodes, bool? isLoading, Object? msg = $none}) =>
      $apply(FieldCopyWithData({
        if (episodes != null) #episodes: episodes,
        if (isLoading != null) #isLoading: isLoading,
        if (msg != $none) #msg: msg
      }));
  @override
  VideoState $make(CopyWithData data) => VideoState(
      episodes: data.get(#episodes, or: $value.episodes),
      isLoading: data.get(#isLoading, or: $value.isLoading),
      msg: data.get(#msg, or: $value.msg));

  @override
  VideoStateCopyWith<$R2, VideoState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VideoStateCopyWithImpl($value, $cast, t);
}
