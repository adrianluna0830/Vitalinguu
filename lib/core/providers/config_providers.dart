import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitalingu/core/constants/app_constants.dart';
import 'package:vitalingu/data/models/global_configuration.dart';
import 'package:vitalingu/data/repositories/hive_repository.dart';
import 'package:vitalingu/domain/services/config_service.dart';

final configServiceProvider = Provider<ConfigService>((ref) {
  return ConfigService(HiveRepository<GlobalConfiguration>(globalSettingsBoxName));
});