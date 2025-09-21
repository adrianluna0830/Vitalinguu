
import 'package:hive_ce/hive.dart';

class AppConfiguration extends HiveObject {
  String geminiApiKey;
  String microsoftApiKey;
  String nativeLanguage;
  String azure_region;

  AppConfiguration({
    this.geminiApiKey = "",
    this.microsoftApiKey = "",
    this.nativeLanguage = "",
    this.azure_region = "",
  });

  bool get isValid {
    return geminiApiKey.trim().isNotEmpty &&
           microsoftApiKey.trim().isNotEmpty &&
           nativeLanguage.trim().isNotEmpty &&
           azure_region.trim().isNotEmpty;
  }
}
