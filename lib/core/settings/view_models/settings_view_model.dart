import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/constants/language_supported_features.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart';

class SettingsState {
  final List<LanguageData> languages;
  final Option<List<String>> validationErrors;
  final AppSettings appSettings;
  final bool isValid;

  SettingsState(this.languages, this.validationErrors, this.appSettings, {this.isValid = false});

}

@injectable
class SettingsViewModel extends Cubit<SettingsState> {
  final AppSettingsManager _appSettingsManager;
  
  SettingsViewModel(this._appSettingsManager) 
      : super(SettingsState(languageDataList, none(), _appSettingsManager.appSettings));

  Future<void> updateAppSettings(AppSettings appSettings) async {
    final isValid = appSettings.isValid;
    if(isValid)
    {
      _appSettingsManager.saveAppSettings(appSettings);
      emit(SettingsState(state.languages, none(), appSettings, isValid: true));
    }
    else
    {
      emit(SettingsState(state.languages, isValid ? none() : some(['Invalid settings']), appSettings, isValid: false));
    }
  }
}
