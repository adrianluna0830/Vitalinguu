// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_settings.dart';

class AppSettingsMapper extends ClassMapperBase<AppSettings> {
  AppSettingsMapper._();

  static AppSettingsMapper? _instance;
  static AppSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppSettings';

  static String _$nativeLanguage(AppSettings v) => v.nativeLanguage;
  static const Field<AppSettings, String> _f$nativeLanguage = Field(
    'nativeLanguage',
    _$nativeLanguage,
  );
  static String _$geminiApiKey(AppSettings v) => v.geminiApiKey;
  static const Field<AppSettings, String> _f$geminiApiKey = Field(
    'geminiApiKey',
    _$geminiApiKey,
  );
  static String _$microsoftApiKey(AppSettings v) => v.microsoftApiKey;
  static const Field<AppSettings, String> _f$microsoftApiKey = Field(
    'microsoftApiKey',
    _$microsoftApiKey,
  );
  static String _$microsoftRegion(AppSettings v) => v.microsoftRegion;
  static const Field<AppSettings, String> _f$microsoftRegion = Field(
    'microsoftRegion',
    _$microsoftRegion,
  );
  static bool _$isValid(AppSettings v) => v.isValid;
  static const Field<AppSettings, bool> _f$isValid = Field(
    'isValid',
    _$isValid,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<AppSettings> fields = const {
    #nativeLanguage: _f$nativeLanguage,
    #geminiApiKey: _f$geminiApiKey,
    #microsoftApiKey: _f$microsoftApiKey,
    #microsoftRegion: _f$microsoftRegion,
    #isValid: _f$isValid,
  };

  static AppSettings _instantiate(DecodingData data) {
    return AppSettings(
      nativeLanguage: data.dec(_f$nativeLanguage),
      geminiApiKey: data.dec(_f$geminiApiKey),
      microsoftApiKey: data.dec(_f$microsoftApiKey),
      microsoftRegion: data.dec(_f$microsoftRegion),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppSettings>(map);
  }

  static AppSettings fromJson(String json) {
    return ensureInitialized().decodeJson<AppSettings>(json);
  }
}

mixin AppSettingsMappable {
  String toJson() {
    return AppSettingsMapper.ensureInitialized().encodeJson<AppSettings>(
      this as AppSettings,
    );
  }

  Map<String, dynamic> toMap() {
    return AppSettingsMapper.ensureInitialized().encodeMap<AppSettings>(
      this as AppSettings,
    );
  }

  AppSettingsCopyWith<AppSettings, AppSettings, AppSettings> get copyWith =>
      _AppSettingsCopyWithImpl<AppSettings, AppSettings>(
        this as AppSettings,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppSettingsMapper.ensureInitialized().stringifyValue(
      this as AppSettings,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppSettingsMapper.ensureInitialized().equalsValue(
      this as AppSettings,
      other,
    );
  }

  @override
  int get hashCode {
    return AppSettingsMapper.ensureInitialized().hashValue(this as AppSettings);
  }
}

extension AppSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppSettings, $Out> {
  AppSettingsCopyWith<$R, AppSettings, $Out> get $asAppSettings =>
      $base.as((v, t, t2) => _AppSettingsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppSettingsCopyWith<$R, $In extends AppSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? nativeLanguage,
    String? geminiApiKey,
    String? microsoftApiKey,
    String? microsoftRegion,
  });
  AppSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppSettings, $Out>
    implements AppSettingsCopyWith<$R, AppSettings, $Out> {
  _AppSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppSettings> $mapper =
      AppSettingsMapper.ensureInitialized();
  @override
  $R call({
    String? nativeLanguage,
    String? geminiApiKey,
    String? microsoftApiKey,
    String? microsoftRegion,
  }) => $apply(
    FieldCopyWithData({
      if (nativeLanguage != null) #nativeLanguage: nativeLanguage,
      if (geminiApiKey != null) #geminiApiKey: geminiApiKey,
      if (microsoftApiKey != null) #microsoftApiKey: microsoftApiKey,
      if (microsoftRegion != null) #microsoftRegion: microsoftRegion,
    }),
  );
  @override
  AppSettings $make(CopyWithData data) => AppSettings(
    nativeLanguage: data.get(#nativeLanguage, or: $value.nativeLanguage),
    geminiApiKey: data.get(#geminiApiKey, or: $value.geminiApiKey),
    microsoftApiKey: data.get(#microsoftApiKey, or: $value.microsoftApiKey),
    microsoftRegion: data.get(#microsoftRegion, or: $value.microsoftRegion),
  );

  @override
  AppSettingsCopyWith<$R2, AppSettings, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppSettingsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

