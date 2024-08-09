// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'theme_state.dart';

class ThemeStateMapper extends ClassMapperBase<ThemeState> {
  ThemeStateMapper._();

  static ThemeStateMapper? _instance;
  static ThemeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ThemeState';

  static bool _$isDark(ThemeState v) => v.isDark;
  static const Field<ThemeState, bool> _f$isDark = Field('isDark', _$isDark);
  static ThemeMode _$themeMode(ThemeState v) => v.themeMode;
  static const Field<ThemeState, ThemeMode> _f$themeMode =
      Field('themeMode', _$themeMode);

  @override
  final MappableFields<ThemeState> fields = const {
    #isDark: _f$isDark,
    #themeMode: _f$themeMode,
  };

  static ThemeState _instantiate(DecodingData data) {
    return ThemeState(
        isDark: data.dec(_f$isDark), themeMode: data.dec(_f$themeMode));
  }

  @override
  final Function instantiate = _instantiate;

  static ThemeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ThemeState>(map);
  }

  static ThemeState fromJson(String json) {
    return ensureInitialized().decodeJson<ThemeState>(json);
  }
}

mixin ThemeStateMappable {
  String toJson() {
    return ThemeStateMapper.ensureInitialized()
        .encodeJson<ThemeState>(this as ThemeState);
  }

  Map<String, dynamic> toMap() {
    return ThemeStateMapper.ensureInitialized()
        .encodeMap<ThemeState>(this as ThemeState);
  }

  ThemeStateCopyWith<ThemeState, ThemeState, ThemeState> get copyWith =>
      _ThemeStateCopyWithImpl(this as ThemeState, $identity, $identity);
  @override
  String toString() {
    return ThemeStateMapper.ensureInitialized()
        .stringifyValue(this as ThemeState);
  }

  @override
  bool operator ==(Object other) {
    return ThemeStateMapper.ensureInitialized()
        .equalsValue(this as ThemeState, other);
  }

  @override
  int get hashCode {
    return ThemeStateMapper.ensureInitialized().hashValue(this as ThemeState);
  }
}

extension ThemeStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ThemeState, $Out> {
  ThemeStateCopyWith<$R, ThemeState, $Out> get $asThemeState =>
      $base.as((v, t, t2) => _ThemeStateCopyWithImpl(v, t, t2));
}

abstract class ThemeStateCopyWith<$R, $In extends ThemeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isDark, ThemeMode? themeMode});
  ThemeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ThemeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ThemeState, $Out>
    implements ThemeStateCopyWith<$R, ThemeState, $Out> {
  _ThemeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ThemeState> $mapper =
      ThemeStateMapper.ensureInitialized();
  @override
  $R call({bool? isDark, ThemeMode? themeMode}) => $apply(FieldCopyWithData({
        if (isDark != null) #isDark: isDark,
        if (themeMode != null) #themeMode: themeMode
      }));
  @override
  ThemeState $make(CopyWithData data) => ThemeState(
      isDark: data.get(#isDark, or: $value.isDark),
      themeMode: data.get(#themeMode, or: $value.themeMode));

  @override
  ThemeStateCopyWith<$R2, ThemeState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ThemeStateCopyWithImpl($value, $cast, t);
}
