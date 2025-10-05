import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalinguu/features/app_startup/app_startup_view.dart';
import 'package:vitalinguu/features/app_startup/app_startup_view_model.dart';

part 'routes.g.dart';

@TypedGoRoute<AppStartupRoute>(path: '/')
class AppStartupRoute extends GoRouteData with $AppStartupRoute {
  const AppStartupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) 
  {
    return BlocProvider(create:   
      (context) => AppStartupViewModelCubit(),
      child: const AppStartupView()
    );
  }
}