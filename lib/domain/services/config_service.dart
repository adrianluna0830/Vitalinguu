import 'package:vitalingu/data/models/global_configuration.dart';
import 'package:vitalingu/data/repositories/hive_repository.dart';

class ConfigService {
  final HiveRepository<GlobalConfiguration> _repo;
  static const String _configKey = 'global';

  ConfigService(this._repo);

  Future<GlobalConfiguration> getConfig() async {
    try {
      final config = await _repo.get(_configKey);
      if (config != null) {
        return config;
      }

      final configs = await _repo.getAll();
      if (configs.isNotEmpty) {
        return configs.first;
      }

      final newConfig = GlobalConfiguration();
      await _repo.add(newConfig, key: _configKey);
      return newConfig;
    } catch (e) {
      final config = GlobalConfiguration();
      await _repo.add(config, key: _configKey);
      return config;
    }
  }

  Future<GlobalConfiguration?> getConfigOrNull() async {
    try {
      final config = await _repo.get(_configKey);
      if (config != null) return config;

      final configs = await _repo.getAll();
      return configs.isNotEmpty ? configs.first : null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> hasConfiguration() async {
    final config = await getConfigOrNull();
    return config != null;
  }

  Future<bool> isConfigurationValid() async {
    final config = await getConfigOrNull();
    if (config == null) return false;
    
    return config.geminiApiKey.isNotEmpty && 
           config.microsoftApiKey.isNotEmpty &&
           config.nativeLanguage.isNotEmpty;
  }

  Future<void> updateCompleteConfig({
    required String geminiKey,
    required String microsoftKey,
    required String nativeLanguage,
  }) async {
    try {
      final existingConfig = await getConfigOrNull();
      
      if (existingConfig != null) {
        existingConfig.geminiApiKey = geminiKey;
        existingConfig.microsoftApiKey = microsoftKey;
        existingConfig.nativeLanguage = nativeLanguage;
        await _repo.update(existingConfig);
      } else {
        final newConfig = GlobalConfiguration();
        newConfig.geminiApiKey = geminiKey;
        newConfig.microsoftApiKey = microsoftKey;
        newConfig.nativeLanguage = nativeLanguage;
        await _repo.add(newConfig, key: _configKey);
      }
    } catch (e) {
      await _repo.deleteAll();
      final newConfig = GlobalConfiguration();
      newConfig.geminiApiKey = geminiKey;
      newConfig.microsoftApiKey = microsoftKey;
      newConfig.nativeLanguage = nativeLanguage;
      await _repo.add(newConfig, key: _configKey);
    }
  }

  Future<void> clearConfiguration() async {
    await _repo.deleteAll();
  }
}