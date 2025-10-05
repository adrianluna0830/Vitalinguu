import 'package:hive_ce/hive.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<AppSettings>()
])

class HiveAdapters {}