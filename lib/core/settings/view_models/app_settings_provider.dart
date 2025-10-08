import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/storage/hive_storage.dart';

part 'app_settings_provider.g.dart';

@Riverpod(keepAlive: true)
class AppSettingsManager extends _$AppSettingsManager {
  final _storage = HiveStorage<AppSettings>();

  @override
  Future<AppSettings> build() async {
    await _storage.initDB();
    final settingsOption = await _storage.getById(AppSettings.globalId);

    return settingsOption.match(
      () => AppSettings(
        nativeLanguage: LanguageData(languageCode: '', languageLocal: []),
        geminiApiKey: '',
        microsoftApiKey: '',
        microsoftRegion: '',
      ),
      (settings) => settings,
    );
  }

  Future<void> updateAppSettings(AppSettings settings) async {
    await _storage.initDB();
    final existingSettings = await _storage.getById(AppSettings.globalId);

    if (existingSettings.isNone()) {
      await _storage.save(AppSettings(
        nativeLanguage: LanguageData(languageCode: '', languageLocal: []),
        geminiApiKey: '',
        microsoftApiKey: '',
        microsoftRegion: '',
      ));
    }

    await _storage.update(settings);
    state = AsyncData(settings);
  }
}
