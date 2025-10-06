// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      LanguageDataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  static List<LanguageData> _$languages(SettingsState v) => v.languages;
  static const Field<SettingsState, List<LanguageData>> _f$languages = Field(
    'languages',
    _$languages,
    opt: true,
    def: const [],
  );
  static LanguageData? _$selectedLanguage(SettingsState v) =>
      v.selectedLanguage;
  static const Field<SettingsState, LanguageData> _f$selectedLanguage = Field(
    'selectedLanguage',
    _$selectedLanguage,
    opt: true,
  );
  static String? _$selectedLanguageName(SettingsState v) =>
      v.selectedLanguageName;
  static const Field<SettingsState, String> _f$selectedLanguageName = Field(
    'selectedLanguageName',
    _$selectedLanguageName,
    opt: true,
  );
  static List<String> _$availableLocales(SettingsState v) => v.availableLocales;
  static const Field<SettingsState, List<String>> _f$availableLocales = Field(
    'availableLocales',
    _$availableLocales,
    opt: true,
    def: const [],
  );
  static String _$geminiApiKey(SettingsState v) => v.geminiApiKey;
  static const Field<SettingsState, String> _f$geminiApiKey = Field(
    'geminiApiKey',
    _$geminiApiKey,
    opt: true,
    def: '',
  );
  static String _$microsoftApiKey(SettingsState v) => v.microsoftApiKey;
  static const Field<SettingsState, String> _f$microsoftApiKey = Field(
    'microsoftApiKey',
    _$microsoftApiKey,
    opt: true,
    def: '',
  );
  static String _$microsoftRegion(SettingsState v) => v.microsoftRegion;
  static const Field<SettingsState, String> _f$microsoftRegion = Field(
    'microsoftRegion',
    _$microsoftRegion,
    opt: true,
    def: '',
  );
  static bool _$isLoading(SettingsState v) => v.isLoading;
  static const Field<SettingsState, bool> _f$isLoading = Field(
    'isLoading',
    _$isLoading,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<SettingsState> fields = const {
    #languages: _f$languages,
    #selectedLanguage: _f$selectedLanguage,
    #selectedLanguageName: _f$selectedLanguageName,
    #availableLocales: _f$availableLocales,
    #geminiApiKey: _f$geminiApiKey,
    #microsoftApiKey: _f$microsoftApiKey,
    #microsoftRegion: _f$microsoftRegion,
    #isLoading: _f$isLoading,
  };

  static SettingsState _instantiate(DecodingData data) {
    return SettingsState(
      languages: data.dec(_f$languages),
      selectedLanguage: data.dec(_f$selectedLanguage),
      selectedLanguageName: data.dec(_f$selectedLanguageName),
      availableLocales: data.dec(_f$availableLocales),
      geminiApiKey: data.dec(_f$geminiApiKey),
      microsoftApiKey: data.dec(_f$microsoftApiKey),
      microsoftRegion: data.dec(_f$microsoftRegion),
      isLoading: data.dec(_f$isLoading),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String toJson() {
    return SettingsStateMapper.ensureInitialized().encodeJson<SettingsState>(
      this as SettingsState,
    );
  }

  Map<String, dynamic> toMap() {
    return SettingsStateMapper.ensureInitialized().encodeMap<SettingsState>(
      this as SettingsState,
    );
  }

  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
  get copyWith => _SettingsStateCopyWithImpl<SettingsState, SettingsState>(
    this as SettingsState,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SettingsStateMapper.ensureInitialized().stringifyValue(
      this as SettingsState,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsStateMapper.ensureInitialized().equalsValue(
      this as SettingsState,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsStateMapper.ensureInitialized().hashValue(
      this as SettingsState,
    );
  }
}

extension SettingsStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsState, $Out> {
  SettingsStateCopyWith<$R, SettingsState, $Out> get $asSettingsState =>
      $base.as((v, t, t2) => _SettingsStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    LanguageData,
    LanguageDataCopyWith<$R, LanguageData, LanguageData>
  >
  get languages;
  LanguageDataCopyWith<$R, LanguageData, LanguageData>? get selectedLanguage;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get availableLocales;
  $R call({
    List<LanguageData>? languages,
    LanguageData? selectedLanguage,
    String? selectedLanguageName,
    List<String>? availableLocales,
    String? geminiApiKey,
    String? microsoftApiKey,
    String? microsoftRegion,
    bool? isLoading,
  });
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SettingsStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsState, $Out>
    implements SettingsStateCopyWith<$R, SettingsState, $Out> {
  _SettingsStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsState> $mapper =
      SettingsStateMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    LanguageData,
    LanguageDataCopyWith<$R, LanguageData, LanguageData>
  >
  get languages => ListCopyWith(
    $value.languages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(languages: v),
  );
  @override
  LanguageDataCopyWith<$R, LanguageData, LanguageData>? get selectedLanguage =>
      $value.selectedLanguage?.copyWith.$chain(
        (v) => call(selectedLanguage: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get availableLocales => ListCopyWith(
    $value.availableLocales,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(availableLocales: v),
  );
  @override
  $R call({
    List<LanguageData>? languages,
    Object? selectedLanguage = $none,
    Object? selectedLanguageName = $none,
    List<String>? availableLocales,
    String? geminiApiKey,
    String? microsoftApiKey,
    String? microsoftRegion,
    bool? isLoading,
  }) => $apply(
    FieldCopyWithData({
      if (languages != null) #languages: languages,
      if (selectedLanguage != $none) #selectedLanguage: selectedLanguage,
      if (selectedLanguageName != $none)
        #selectedLanguageName: selectedLanguageName,
      if (availableLocales != null) #availableLocales: availableLocales,
      if (geminiApiKey != null) #geminiApiKey: geminiApiKey,
      if (microsoftApiKey != null) #microsoftApiKey: microsoftApiKey,
      if (microsoftRegion != null) #microsoftRegion: microsoftRegion,
      if (isLoading != null) #isLoading: isLoading,
    }),
  );
  @override
  SettingsState $make(CopyWithData data) => SettingsState(
    languages: data.get(#languages, or: $value.languages),
    selectedLanguage: data.get(#selectedLanguage, or: $value.selectedLanguage),
    selectedLanguageName: data.get(
      #selectedLanguageName,
      or: $value.selectedLanguageName,
    ),
    availableLocales: data.get(#availableLocales, or: $value.availableLocales),
    geminiApiKey: data.get(#geminiApiKey, or: $value.geminiApiKey),
    microsoftApiKey: data.get(#microsoftApiKey, or: $value.microsoftApiKey),
    microsoftRegion: data.get(#microsoftRegion, or: $value.microsoftRegion),
    isLoading: data.get(#isLoading, or: $value.isLoading),
  );

  @override
  SettingsStateCopyWith<$R2, SettingsState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

