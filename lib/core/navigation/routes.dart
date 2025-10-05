import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalinguu/core/settings/view/settings_view.dart';
import 'package:vitalinguu/core/settings/view_models/app_settings_manager.dart';
import 'package:vitalinguu/features/languge_selection/language_selection_view.dart';
import 'package:vitalinguu/injection.dart';

part 'routes.g.dart';


@TypedGoRoute<LanguageSelectionRoute>(path: '/language-selection')
class LanguageSelectionRoute extends GoRouteData with $LanguageSelectionRoute {
  const LanguageSelectionRoute();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    AppSettingsManager appSettingsManager = getIt<AppSettingsManager>();
    final settings =  appSettingsManager.appSettings;
    if (!settings.isValid) {
      return SettingsRoute().location;
    }
    return null;
  }
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LanguageSelectionView();
  }
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsView();
  }
}
