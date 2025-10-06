// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_local.dart';

class LanguageLocalMapper extends ClassMapperBase<LanguageLocal> {
  LanguageLocalMapper._();

  static LanguageLocalMapper? _instance;
  static LanguageLocalMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageLocalMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageLocal';

  static String _$localCode(LanguageLocal v) => v.localCode;
  static const Field<LanguageLocal, String> _f$localCode = Field(
    'localCode',
    _$localCode,
  );
  static String _$locale(LanguageLocal v) => v.locale;
  static const Field<LanguageLocal, String> _f$locale = Field(
    'locale',
    _$locale,
  );
  static bool _$pronunciationAssessmentSupported(LanguageLocal v) =>
      v.pronunciationAssessmentSupported;
  static const Field<LanguageLocal, bool> _f$pronunciationAssessmentSupported =
      Field(
        'pronunciationAssessmentSupported',
        _$pronunciationAssessmentSupported,
      );
  static bool _$fastApiSupported(LanguageLocal v) => v.fastApiSupported;
  static const Field<LanguageLocal, bool> _f$fastApiSupported = Field(
    'fastApiSupported',
    _$fastApiSupported,
  );

  @override
  final MappableFields<LanguageLocal> fields = const {
    #localCode: _f$localCode,
    #locale: _f$locale,
    #pronunciationAssessmentSupported: _f$pronunciationAssessmentSupported,
    #fastApiSupported: _f$fastApiSupported,
  };

  static LanguageLocal _instantiate(DecodingData data) {
    return LanguageLocal(
      localCode: data.dec(_f$localCode),
      locale: data.dec(_f$locale),
      pronunciationAssessmentSupported: data.dec(
        _f$pronunciationAssessmentSupported,
      ),
      fastApiSupported: data.dec(_f$fastApiSupported),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageLocal fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageLocal>(map);
  }

  static LanguageLocal fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageLocal>(json);
  }
}

mixin LanguageLocalMappable {
  String toJson() {
    return LanguageLocalMapper.ensureInitialized().encodeJson<LanguageLocal>(
      this as LanguageLocal,
    );
  }

  Map<String, dynamic> toMap() {
    return LanguageLocalMapper.ensureInitialized().encodeMap<LanguageLocal>(
      this as LanguageLocal,
    );
  }

  LanguageLocalCopyWith<LanguageLocal, LanguageLocal, LanguageLocal>
  get copyWith => _LanguageLocalCopyWithImpl<LanguageLocal, LanguageLocal>(
    this as LanguageLocal,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LanguageLocalMapper.ensureInitialized().stringifyValue(
      this as LanguageLocal,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageLocalMapper.ensureInitialized().equalsValue(
      this as LanguageLocal,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageLocalMapper.ensureInitialized().hashValue(
      this as LanguageLocal,
    );
  }
}

extension LanguageLocalValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageLocal, $Out> {
  LanguageLocalCopyWith<$R, LanguageLocal, $Out> get $asLanguageLocal =>
      $base.as((v, t, t2) => _LanguageLocalCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguageLocalCopyWith<$R, $In extends LanguageLocal, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? localCode,
    String? locale,
    bool? pronunciationAssessmentSupported,
    bool? fastApiSupported,
  });
  LanguageLocalCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LanguageLocalCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageLocal, $Out>
    implements LanguageLocalCopyWith<$R, LanguageLocal, $Out> {
  _LanguageLocalCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageLocal> $mapper =
      LanguageLocalMapper.ensureInitialized();
  @override
  $R call({
    String? localCode,
    String? locale,
    bool? pronunciationAssessmentSupported,
    bool? fastApiSupported,
  }) => $apply(
    FieldCopyWithData({
      if (localCode != null) #localCode: localCode,
      if (locale != null) #locale: locale,
      if (pronunciationAssessmentSupported != null)
        #pronunciationAssessmentSupported: pronunciationAssessmentSupported,
      if (fastApiSupported != null) #fastApiSupported: fastApiSupported,
    }),
  );
  @override
  LanguageLocal $make(CopyWithData data) => LanguageLocal(
    localCode: data.get(#localCode, or: $value.localCode),
    locale: data.get(#locale, or: $value.locale),
    pronunciationAssessmentSupported: data.get(
      #pronunciationAssessmentSupported,
      or: $value.pronunciationAssessmentSupported,
    ),
    fastApiSupported: data.get(#fastApiSupported, or: $value.fastApiSupported),
  );

  @override
  LanguageLocalCopyWith<$R2, LanguageLocal, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageLocalCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

