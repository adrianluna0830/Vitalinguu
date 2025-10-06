import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';
import 'package:vitalinguu/injection.dart';

@lazySingleton
class AppSettingsManager {
  final StorageInterface<AppSettings> _storage = getIt<StorageInterface<AppSettings>>();

  late AppSettings _appSettings;
  AppSettings get appSettings => _appSettings;

  AppSettingsManager()
  {
    _appSettings = _storage.getByIdSync(AppSettings.globalId).getOrElse(() => AppSettings(
      nativeLanguage: LanguageData(
        fastApiSupported: false,
        languageCode: '',
        languageName: '',
        locale: '',
        pronunciationAssessmentSupported: false,
      ),
      geminiApiKey: '',
      microsoftApiKey: '',
      microsoftRegion: '',
    ));
  }

  Future<AppSettings> saveAppSettings(AppSettings settings) async {
    await _storage.save(settings);
    _appSettings = settings;
    return settings;
  }

}