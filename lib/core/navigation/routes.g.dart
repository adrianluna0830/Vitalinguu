// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$appStartupRoute];

RouteBase get $appStartupRoute =>
    GoRouteData.$route(path: '/', factory: $AppStartupRoute._fromState);

mixin $AppStartupRoute on GoRouteData {
  static AppStartupRoute _fromState(GoRouterState state) =>
      const AppStartupRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
