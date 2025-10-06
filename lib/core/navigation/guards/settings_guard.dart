import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/navigation/app_router.gr.dart';
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart';

@injectable
class SettingsGuard extends AutoRouteGuard {
  final AppSettingsManager _appSettingsManager;

  SettingsGuard(this._appSettingsManager);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final settings = _appSettingsManager.appSettings;

    if (resolver.route.name == SettingsRoute.name && settings.isValid) {
      resolver.redirectUntil(
        LanguageSelectionRoute(),
        replace: true,
      );
    } else {
      resolver.next();
    }
  }
}
