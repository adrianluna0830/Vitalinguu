import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/navigation/guards/settings_guard.dart';

import 'app_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  final SettingsGuard _settingsGuard;

  AppRouter(this._settingsGuard);

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SettingsRoute.page,
          initial: true,
          guards: [_settingsGuard],
        ),
        AutoRoute(page: LanguageSelectionRoute.page),
      ];
}
