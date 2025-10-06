import 'package:dart_mappable/dart_mappable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vitalinguu/core/base/id_base.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';

part 'app_settings.mapper.dart';

@MappableClass()
class AppSettings extends IdBase<String> with AppSettingsMappable {
  final LanguageData nativeLanguage;
  final String geminiApiKey;
  final String microsoftApiKey;
  final String microsoftRegion;
  

  static String globalId = 'app_settings';

  AppSettings({
    required this.nativeLanguage,
    required this.geminiApiKey,
    required this.microsoftApiKey,
    required this.microsoftRegion,
  }) : super(id: Some(globalId));

  bool get isValid =>
      nativeLanguage.isValid &&
      geminiApiKey.trim().isNotEmpty &&
      microsoftApiKey.trim().isNotEmpty &&
      microsoftRegion.trim().isNotEmpty;
}