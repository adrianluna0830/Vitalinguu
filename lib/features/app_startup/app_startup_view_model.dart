import 'package:bloc/bloc.dart';
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart';
import 'package:vitalinguu/injection.dart';

class AppStartupViewModelCubit extends Cubit<bool> {
  final AppSettingsManager _appSettingsManager = getIt<AppSettingsManager>();
  AppStartupViewModelCubit() : super(true) {
    _loadSettings();
  }

  void _loadSettings()  {
    emit(true); 
    final settings =  _appSettingsManager.appSettings;
    final isValid = settings.isValid;
    print('App settings are valid: $isValid');
    emit(false); 
  }
}
