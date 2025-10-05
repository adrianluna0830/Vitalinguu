import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalinguu/core/navigation/routes.dart';

void main() {

  final GoRouter router = GoRouter(routes: $appRoutes);
  runApp(MaterialApp.router(
    routerConfig: router
  ));
}
