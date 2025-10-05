import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalinguu/features/app_startup/app_startup_view.dart';

part 'routes.g.dart';

@TypedGoRoute<AppStartupRoute>(path: '/')
class AppStartupRoute extends GoRouteData with $AppStartupRoute {
  const AppStartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AppStartupView();
}