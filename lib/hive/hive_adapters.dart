
import 'package:hive_ce/hive.dart';
import 'package:vitalingu/shared/data/models/app_configuration.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<AppConfiguration>()
])

class HiveAdapters {}