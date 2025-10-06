
import 'package:dart_mappable/dart_mappable.dart';

part 'language_local.mapper.dart';

@MappableClass()
class LanguageLocal with LanguageLocalMappable {
  final String localCode;
  final String locale;
  final bool pronunciationAssessmentSupported;
  final bool fastApiSupported;

  LanguageLocal({
    required this.localCode,
    required this.locale,
    required this.pronunciationAssessmentSupported,
    required this.fastApiSupported,
  });
}
