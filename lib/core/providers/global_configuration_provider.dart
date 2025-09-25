import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitalingu/shared/data/models/app_configuration.dart';
import 'package:vitalingu/shared/data/repositories/local_storage_repository.dart';

final globalConfigurationProvider = Provider<ConfigurationService>((ref) {
  return ConfigurationService();
});

class ConfigurationService {
  final LocalStorageRepository<AppConfiguration> _repo = LocalStorageRepository<AppConfiguration>("global_configuration_box");
  static const String _configKey = 'global';

Future<AppConfiguration> getOrCreateConfiguration() async {
  final globalConfiguration = await _repo.get(_configKey);
  if (globalConfiguration == null) {
    final newConfig = AppConfiguration();
    await _repo.add(newConfig, {}, key: _configKey); // clave explícita
    return newConfig;
  }
  return globalConfiguration;
}

  Future<void> saveConfiguration(AppConfiguration config) async {
    await _repo.update(config);
  }
}