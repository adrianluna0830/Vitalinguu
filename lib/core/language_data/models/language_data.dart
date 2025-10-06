import 'package:dart_mappable/dart_mappable.dart';
import 'package:vitalinguu/core/base/id_base.dart';

part 'language_data.mapper.dart';

@MappableClass()
class LanguageData extends IdBase<String> with LanguageDataMappable {
  final bool fastApiSupported;
  final String languageCode;
  final String languageName;
  final String locale;
  final bool pronunciationAssessmentSupported;

  LanguageData({
    required this.fastApiSupported,
    required this.languageCode,
    required this.languageName,
    required this.locale,
    required this.pronunciationAssessmentSupported,
  });

  bool get isValid =>
      languageCode.trim().isNotEmpty &&
      languageName.trim().isNotEmpty &&
      locale.trim().isNotEmpty;
}