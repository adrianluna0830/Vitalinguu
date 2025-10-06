// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:vitalinguu/core/language_data/models/language_data.dart'
    as _i1058;
import 'package:vitalinguu/core/settings/models/app_settings.dart' as _i777;
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart'
    as _i327;
import 'package:vitalinguu/core/storage/generic_storage_resolvers.dart'
    as _i190;
import 'package:vitalinguu/core/storage/storage_interface.dart' as _i283;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    await gh.factoryAsync<_i283.StorageInterface<_i777.AppSettings>>(
      () => modules.appSettingsStorage,
      preResolve: true,
    );
    await gh.factoryAsync<_i283.StorageInterface<_i1058.LanguageData>>(
      () => modules.languagesDataStorage,
      preResolve: true,
    );
    gh.lazySingleton<_i327.AppSettingsManager>(
      () => _i327.AppSettingsManager(),
    );
    return this;
  }
}

class _$Modules extends _i190.Modules {}
