import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/storage/get_storage.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';
import 'package:vitalinguu/injection.dart';


@module
abstract class AppModule {
  @preResolve
  Future<StorageInterface<AppSettings>> get appSettingsStorage async {
    return await getStorage<AppSettings>();
  }
}

@lazySingleton
class AppSettingsManager {
  final StorageInterface<AppSettings> _storage = getIt<StorageInterface<AppSettings>>();

  late AppSettings _appSettings;
  AppSettings get appSettings => _appSettings;

  AppSettingsManager()
  {
    _appSettings = _storage.getByIdSync(AppSettings.globalId).getOrElse(() => AppSettings(
      nativeLanguage: '',
      geminiApiKey: '',
      microsoftApiKey: '',
      microsoftRegion: '',
    ));
  }

  Future<AppSettings> saveAppSettings(AppSettings settings) async {
    await _storage.save(settings);
    return settings;
  }

}
