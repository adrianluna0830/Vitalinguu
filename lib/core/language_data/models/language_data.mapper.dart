// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_data.dart';

class LanguageDataMapper extends ClassMapperBase<LanguageData> {
  LanguageDataMapper._();

  static LanguageDataMapper? _instance;
  static LanguageDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageDataMapper._());
      LanguageLocalMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageData';

  static String _$languageCode(LanguageData v) => v.languageCode;
  static const Field<LanguageData, String> _f$languageCode = Field(
    'languageCode',
    _$languageCode,
  );
  static List<LanguageLocal> _$languageLocal(LanguageData v) => v.languageLocal;
  static const Field<LanguageData, List<LanguageLocal>> _f$languageLocal =
      Field('languageLocal', _$languageLocal);
  static bool _$isValid(LanguageData v) => v.isValid;
  static const Field<LanguageData, bool> _f$isValid = Field(
    'isValid',
    _$isValid,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<LanguageData> fields = const {
    #languageCode: _f$languageCode,
    #languageLocal: _f$languageLocal,
    #isValid: _f$isValid,
  };

  static LanguageData _instantiate(DecodingData data) {
    return LanguageData(
      languageCode: data.dec(_f$languageCode),
      languageLocal: data.dec(_f$languageLocal),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageData>(map);
  }

  static LanguageData fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageData>(json);
  }
}

mixin LanguageDataMappable {
  String toJson() {
    return LanguageDataMapper.ensureInitialized().encodeJson<LanguageData>(
      this as LanguageData,
    );
  }

  Map<String, dynamic> toMap() {
    return LanguageDataMapper.ensureInitialized().encodeMap<LanguageData>(
      this as LanguageData,
    );
  }

  LanguageDataCopyWith<LanguageData, LanguageData, LanguageData> get copyWith =>
      _LanguageDataCopyWithImpl<LanguageData, LanguageData>(
        this as LanguageData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguageDataMapper.ensureInitialized().stringifyValue(
      this as LanguageData,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageDataMapper.ensureInitialized().equalsValue(
      this as LanguageData,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageDataMapper.ensureInitialized().hashValue(
      this as LanguageData,
    );
  }
}

extension LanguageDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageData, $Out> {
  LanguageDataCopyWith<$R, LanguageData, $Out> get $asLanguageData =>
      $base.as((v, t, t2) => _LanguageDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguageDataCopyWith<$R, $In extends LanguageData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    LanguageLocal,
    LanguageLocalCopyWith<$R, LanguageLocal, LanguageLocal>
  >
  get languageLocal;
  $R call({String? languageCode, List<LanguageLocal>? languageLocal});
  LanguageDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LanguageDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageData, $Out>
    implements LanguageDataCopyWith<$R, LanguageData, $Out> {
  _LanguageDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageData> $mapper =
      LanguageDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    LanguageLocal,
    LanguageLocalCopyWith<$R, LanguageLocal, LanguageLocal>
  >
  get languageLocal => ListCopyWith(
    $value.languageLocal,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(languageLocal: v),
  );
  @override
  $R call({String? languageCode, List<LanguageLocal>? languageLocal}) => $apply(
    FieldCopyWithData({
      if (languageCode != null) #languageCode: languageCode,
      if (languageLocal != null) #languageLocal: languageLocal,
    }),
  );
  @override
  LanguageData $make(CopyWithData data) => LanguageData(
    languageCode: data.get(#languageCode, or: $value.languageCode),
    languageLocal: data.get(#languageLocal, or: $value.languageLocal),
  );

  @override
  LanguageDataCopyWith<$R2, LanguageData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

