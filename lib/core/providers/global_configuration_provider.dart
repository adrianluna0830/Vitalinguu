import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vitalingu/features/configuration/presentation/screens/configuration_service.dart';

final globalConfigurationProvider = Provider<ConfigurationService>((ref) {
  return ConfigurationService();
});