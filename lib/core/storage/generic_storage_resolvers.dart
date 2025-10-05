import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/storage/get_storage.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';

@module
abstract class Modules {
  @preResolve
  Future<StorageInterface<AppSettings>> get appSettingsStorage async {
    return await getStorage<AppSettings>();
  }

  @preResolve
  Future<StorageInterface<LanguageData>> get languagesDataStorage async {
    return await getStorage<LanguageData>();
  }

}
