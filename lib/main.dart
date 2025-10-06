import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalinguu/core/navigation/routes.dart';
import 'package:vitalinguu/hive/hive_registrar.g.dart';
import 'package:vitalinguu/injection.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();

  await configureDependencies();
  final GoRouter router = GoRouter(routes: $appRoutes, initialLocation: SettingsRoute().location);
  runApp(MaterialApp.router(
    routerConfig: router
  ));
}
