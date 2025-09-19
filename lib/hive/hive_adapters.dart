
import 'package:hive_ce/hive.dart';
import 'package:vitalingu/data/models/global_configuration.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<GlobalConfiguration>()
])

class HiveAdapters {}