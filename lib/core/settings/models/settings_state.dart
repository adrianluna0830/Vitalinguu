import 'package:dart_mappable/dart_mappable.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';

part 'settings_state.mapper.dart';

@MappableClass()
class SettingsState with SettingsStateMappable {
  final List<LanguageData> languages;
  final LanguageData? selectedLanguage;
  final String? selectedLanguageName; // Nombre del idioma seleccionado
  final List<String> availableLocales;
  final String geminiApiKey;
  final String microsoftApiKey;
  final String microsoftRegion;
  final bool isLoading;

  SettingsState({
    this.languages = const [],
    this.selectedLanguage,
    this.selectedLanguageName,
    this.availableLocales = const [],
    this.geminiApiKey = '',
    this.microsoftApiKey = '',
    this.microsoftRegion = '',
    this.isLoading = true,
  });
}
