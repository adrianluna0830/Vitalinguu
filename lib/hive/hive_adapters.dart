import 'package:hive_ce/hive.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/language_progress/models/language_progress_data.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<AppSettings>(),
  AdapterSpec<LanguageData>(),
  AdapterSpec<LanguageProgressData>(),
])

class HiveAdapters {}