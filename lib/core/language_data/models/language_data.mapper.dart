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
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageData';

  static bool _$fastApiSupported(LanguageData v) => v.fastApiSupported;
  static const Field<LanguageData, bool> _f$fastApiSupported = Field(
    'fastApiSupported',
    _$fastApiSupported,
  );
  static String _$languageCode(LanguageData v) => v.languageCode;
  static const Field<LanguageData, String> _f$languageCode = Field(
    'languageCode',
    _$languageCode,
  );
  static String _$languageName(LanguageData v) => v.languageName;
  static const Field<LanguageData, String> _f$languageName = Field(
    'languageName',
    _$languageName,
  );
  static String _$locale(LanguageData v) => v.locale;
  static const Field<LanguageData, String> _f$locale = Field(
    'locale',
    _$locale,
  );
  static bool _$pronunciationAssessmentSupported(LanguageData v) =>
      v.pronunciationAssessmentSupported;
  static const Field<LanguageData, bool> _f$pronunciationAssessmentSupported =
      Field(
        'pronunciationAssessmentSupported',
        _$pronunciationAssessmentSupported,
      );
  static bool _$isValid(LanguageData v) => v.isValid;
  static const Field<LanguageData, bool> _f$isValid = Field(
    'isValid',
    _$isValid,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<LanguageData> fields = const {
    #fastApiSupported: _f$fastApiSupported,
    #languageCode: _f$languageCode,
    #languageName: _f$languageName,
    #locale: _f$locale,
    #pronunciationAssessmentSupported: _f$pronunciationAssessmentSupported,
    #isValid: _f$isValid,
  };

  static LanguageData _instantiate(DecodingData data) {
    return LanguageData(
      fastApiSupported: data.dec(_f$fastApiSupported),
      languageCode: data.dec(_f$languageCode),
      languageName: data.dec(_f$languageName),
      locale: data.dec(_f$locale),
      pronunciationAssessmentSupported: data.dec(
        _f$pronunciationAssessmentSupported,
      ),
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
  $R call({
    bool? fastApiSupported,
    String? languageCode,
    String? languageName,
    String? locale,
    bool? pronunciationAssessmentSupported,
  });
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
  $R call({
    bool? fastApiSupported,
    String? languageCode,
    String? languageName,
    String? locale,
    bool? pronunciationAssessmentSupported,
  }) => $apply(
    FieldCopyWithData({
      if (fastApiSupported != null) #fastApiSupported: fastApiSupported,
      if (languageCode != null) #languageCode: languageCode,
      if (languageName != null) #languageName: languageName,
      if (locale != null) #locale: locale,
      if (pronunciationAssessmentSupported != null)
        #pronunciationAssessmentSupported: pronunciationAssessmentSupported,
    }),
  );
  @override
  LanguageData $make(CopyWithData data) => LanguageData(
    fastApiSupported: data.get(#fastApiSupported, or: $value.fastApiSupported),
    languageCode: data.get(#languageCode, or: $value.languageCode),
    languageName: data.get(#languageName, or: $value.languageName),
    locale: data.get(#locale, or: $value.locale),
    pronunciationAssessmentSupported: data.get(
      #pronunciationAssessmentSupported,
      or: $value.pronunciationAssessmentSupported,
    ),
  );

  @override
  LanguageDataCopyWith<$R2, LanguageData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

