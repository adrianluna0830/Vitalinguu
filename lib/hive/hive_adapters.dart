import 'package:hivez_flutter/hivez_flutter.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/language_data/models/language_local.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<AppSettings>(),
  AdapterSpec<LanguageData>(),
  AdapterSpec<LanguageLocal>(),
])
class HiveAdapters {}

