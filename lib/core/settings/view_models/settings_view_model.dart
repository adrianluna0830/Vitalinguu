import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/language_data/view_models/language_data_manager.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/settings/models/settings_state.dart';
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart';
import 'package:vitalinguu/injection.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  final LanguageDataManager _languageDataManager = getIt<LanguageDataManager>();
  final AppSettingsManager _appSettingsManager = getIt<AppSettingsManager>();

  SettingsViewModel() : super(SettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final languages = await _languageDataManager.loadAllLanguages();
    final settings = _appSettingsManager.appSettings;

    LanguageData? selectedLang;
    if (settings.nativeLanguage.languageCode.isNotEmpty &&
        settings.nativeLanguage.languageName.isNotEmpty) {
      final exists = languages.any(
        (lang) =>
            lang.languageCode == settings.nativeLanguage.languageCode &&
            lang.locale == settings.nativeLanguage.locale,
      );

      if (exists) {
        selectedLang = settings.nativeLanguage;
      }
    }

    emit(
      state.copyWith(
        languages: languages,
        selectedLanguage: selectedLang,
        selectedLanguageName: selectedLang?.languageName,
        availableLocales: selectedLang != null
            ? getLocalesForLanguage(selectedLang.languageName)
            : [],
        geminiApiKey: settings.geminiApiKey,
        microsoftApiKey: settings.microsoftApiKey,
        microsoftRegion: settings.microsoftRegion,
        isLoading: false,
      ),
    );
  }

  void selectLanguage(String languageName) {
    final locales = getLocalesForLanguage(languageName);
    
    // Si no hay locales o solo hay uno, selecciona automáticamente
    if (locales.isEmpty) {
      final langWithoutLocale = state.languages.firstWhere(
        (lang) => lang.languageName == languageName,
      );
      emit(
        state.copyWith(
          selectedLanguage: langWithoutLocale,
          selectedLanguageName: languageName,
          availableLocales: [],
        ),
      );
    } else if (locales.length == 1) {
      // Si solo hay un locale, seleccionarlo automáticamente
      final selectedLang = state.languages.firstWhere(
        (lang) => lang.languageName == languageName && lang.locale == locales.first,
      );
      emit(
        state.copyWith(
          selectedLanguage: selectedLang,
          selectedLanguageName: languageName,
          availableLocales: locales,
        ),
      );
    } else {
      // Si hay múltiples locales, mostrar las opciones
      emit(
        state.copyWith(
          selectedLanguage: null,
          selectedLanguageName: languageName,
          availableLocales: locales,
        ),
      );
    }
  }

  void selectLocale(String locale) {
    final currentLanguageName = state.selectedLanguageName;

    if (currentLanguageName == null || currentLanguageName.isEmpty) return;

    // Seleccionar el idioma con el locale específico
    final selectedLang = state.languages.firstWhere(
      (lang) =>
          lang.languageName == currentLanguageName &&
          lang.locale == locale,
    );
    emit(state.copyWith(selectedLanguage: selectedLang));
  }

  void updateGeminiApiKey(String value) {
    emit(state.copyWith(geminiApiKey: value));
  }

  void updateMicrosoftApiKey(String value) {
    emit(state.copyWith(microsoftApiKey: value));
  }

  void updateMicrosoftRegion(String value) {
    emit(state.copyWith(microsoftRegion: value));
  }

  Future<Either<Exception, Unit>> saveSettings() async {
    final selectedLanguage = state.selectedLanguage;
    if (selectedLanguage == null) {
      return Left(Exception('Please select a language'));
    }

    if (!selectedLanguage.isValid) {
      return Left(Exception('Selected language is not valid'));
    }

    final exists = state.languages.any(
      (lang) =>
          lang.languageCode == selectedLanguage.languageCode &&
          lang.locale == selectedLanguage.locale,
    );

    if (!exists) {
      return Left(Exception(
        'Selected language does not exist in available languages',
      ));
    }

    final settings = AppSettings(
      nativeLanguage: selectedLanguage,
      geminiApiKey: state.geminiApiKey,
      microsoftApiKey: state.microsoftApiKey,
      microsoftRegion: state.microsoftRegion,
    );

    if (!settings.isValid) {
      return Left(Exception('Please fill all required fields'));
    }

    await _appSettingsManager.saveAppSettings(settings);

    return const Right(unit);
  }

  List<String> get uniqueLanguages {
    return state.languages.map((lang) => lang.languageName).toSet().toList()
      ..sort();
  }

  List<String> getLocalesForLanguage(String languageName) {
    return state.languages
        .where((lang) => lang.languageName == languageName)
        .map((lang) => lang.locale)
        .where((locale) => locale.isNotEmpty)
        .toList();
  }
}
