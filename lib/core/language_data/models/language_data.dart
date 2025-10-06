import 'package:dart_mappable/dart_mappable.dart';
import 'package:vitalinguu/core/base/id_base.dart';
import 'package:vitalinguu/core/language_data/models/language_local.dart';

part 'language_data.mapper.dart';

@MappableClass()
class LanguageData extends IdBase<String> with LanguageDataMappable {
  final String languageCode;
  final List<LanguageLocal> languageLocal;

  LanguageData({
    required this.languageCode,
    required this.languageLocal,
  });

  bool get isValid => languageLocal.isNotEmpty && languageCode.trim().isNotEmpty;
}

