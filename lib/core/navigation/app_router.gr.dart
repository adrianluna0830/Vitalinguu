// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:vitalinguu/core/settings/view/settings_view.dart' as _i2;
import 'package:vitalinguu/features/languge_selection/language_selection_view.dart'
    as _i1;

/// generated route for
/// [_i1.LanguageSelectionView]
class LanguageSelectionRoute extends _i3.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i3.PageRouteInfo>? children})
    : super(LanguageSelectionRoute.name, initialChildren: children);

  static const String name = 'LanguageSelectionRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.LanguageSelectionView();
    },
  );
}

/// generated route for
/// [_i2.SettingsView]
class SettingsRoute extends _i3.PageRouteInfo<void> {
  const SettingsRoute({List<_i3.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i3.WrappedRoute(child: const _i2.SettingsView());
    },
  );
}
