// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'downloading_state.dart';

class DownloadingStateMapper extends ClassMapperBase<DownloadingState> {
  DownloadingStateMapper._();

  static DownloadingStateMapper? _instance;
  static DownloadingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DownloadingStateMapper._());
      VideoInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DownloadingState';

  static List<VideoInfo> _$videoInfoList(DownloadingState v) => v.videoInfoList;
  static const Field<DownloadingState, List<VideoInfo>> _f$videoInfoList =
      Field('videoInfoList', _$videoInfoList);

  @override
  final MappableFields<DownloadingState> fields = const {
    #videoInfoList: _f$videoInfoList,
  };

  static DownloadingState _instantiate(DecodingData data) {
    return DownloadingState(videoInfoList: data.dec(_f$videoInfoList));
  }

  @override
  final Function instantiate = _instantiate;

  static DownloadingState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DownloadingState>(map);
  }

  static DownloadingState fromJson(String json) {
    return ensureInitialized().decodeJson<DownloadingState>(json);
  }
}

mixin DownloadingStateMappable {
  String toJson() {
    return DownloadingStateMapper.ensureInitialized()
        .encodeJson<DownloadingState>(this as DownloadingState);
  }

  Map<String, dynamic> toMap() {
    return DownloadingStateMapper.ensureInitialized()
        .encodeMap<DownloadingState>(this as DownloadingState);
  }

  DownloadingStateCopyWith<DownloadingState, DownloadingState, DownloadingState>
      get copyWith => _DownloadingStateCopyWithImpl(
          this as DownloadingState, $identity, $identity);
  @override
  String toString() {
    return DownloadingStateMapper.ensureInitialized()
        .stringifyValue(this as DownloadingState);
  }

  @override
  bool operator ==(Object other) {
    return DownloadingStateMapper.ensureInitialized()
        .equalsValue(this as DownloadingState, other);
  }

  @override
  int get hashCode {
    return DownloadingStateMapper.ensureInitialized()
        .hashValue(this as DownloadingState);
  }
}

extension DownloadingStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DownloadingState, $Out> {
  DownloadingStateCopyWith<$R, DownloadingState, $Out>
      get $asDownloadingState =>
          $base.as((v, t, t2) => _DownloadingStateCopyWithImpl(v, t, t2));
}

abstract class DownloadingStateCopyWith<$R, $In extends DownloadingState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, VideoInfo, VideoInfoCopyWith<$R, VideoInfo, VideoInfo>>
      get videoInfoList;
  $R call({List<VideoInfo>? videoInfoList});
  DownloadingStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DownloadingStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DownloadingState, $Out>
    implements DownloadingStateCopyWith<$R, DownloadingState, $Out> {
  _DownloadingStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DownloadingState> $mapper =
      DownloadingStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, VideoInfo, VideoInfoCopyWith<$R, VideoInfo, VideoInfo>>
      get videoInfoList => ListCopyWith($value.videoInfoList,
          (v, t) => v.copyWith.$chain(t), (v) => call(videoInfoList: v));
  @override
  $R call({List<VideoInfo>? videoInfoList}) => $apply(FieldCopyWithData(
      {if (videoInfoList != null) #videoInfoList: videoInfoList}));
  @override
  DownloadingState $make(CopyWithData data) => DownloadingState(
      videoInfoList: data.get(#videoInfoList, or: $value.videoInfoList));

  @override
  DownloadingStateCopyWith<$R2, DownloadingState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DownloadingStateCopyWithImpl($value, $cast, t);
}
