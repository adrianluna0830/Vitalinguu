// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_progress_data.dart';

class LanguageProgressDataMapper extends ClassMapperBase<LanguageProgressData> {
  LanguageProgressDataMapper._();

  static LanguageProgressDataMapper? _instance;
  static LanguageProgressDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageProgressDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageProgressData';

  @override
  final MappableFields<LanguageProgressData> fields = const {};

  static LanguageProgressData _instantiate(DecodingData data) {
    return LanguageProgressData();
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageProgressData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageProgressData>(map);
  }

  static LanguageProgressData fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageProgressData>(json);
  }
}

mixin LanguageProgressDataMappable {
  String toJson() {
    return LanguageProgressDataMapper.ensureInitialized()
        .encodeJson<LanguageProgressData>(this as LanguageProgressData);
  }

  Map<String, dynamic> toMap() {
    return LanguageProgressDataMapper.ensureInitialized()
        .encodeMap<LanguageProgressData>(this as LanguageProgressData);
  }

  LanguageProgressDataCopyWith<
    LanguageProgressData,
    LanguageProgressData,
    LanguageProgressData
  >
  get copyWith =>
      _LanguageProgressDataCopyWithImpl<
        LanguageProgressData,
        LanguageProgressData
      >(this as LanguageProgressData, $identity, $identity);
  @override
  String toString() {
    return LanguageProgressDataMapper.ensureInitialized().stringifyValue(
      this as LanguageProgressData,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageProgressDataMapper.ensureInitialized().equalsValue(
      this as LanguageProgressData,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageProgressDataMapper.ensureInitialized().hashValue(
      this as LanguageProgressData,
    );
  }
}

extension LanguageProgressDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageProgressData, $Out> {
  LanguageProgressDataCopyWith<$R, LanguageProgressData, $Out>
  get $asLanguageProgressData => $base.as(
    (v, t, t2) => _LanguageProgressDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageProgressDataCopyWith<
  $R,
  $In extends LanguageProgressData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  LanguageProgressDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageProgressDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageProgressData, $Out>
    implements LanguageProgressDataCopyWith<$R, LanguageProgressData, $Out> {
  _LanguageProgressDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageProgressData> $mapper =
      LanguageProgressDataMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  LanguageProgressData $make(CopyWithData data) => LanguageProgressData();

  @override
  LanguageProgressDataCopyWith<$R2, LanguageProgressData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageProgressDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

