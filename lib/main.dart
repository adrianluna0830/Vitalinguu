import 'package:flutter/material.dart';
import 'package:vitalinguu/core/navigation/app_router.dart';
import 'package:vitalinguu/hive/hive_registrar.g.dart';
import 'package:vitalinguu/injection.dart';
import 'package:hivez_flutter/hivez_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();

  await configureDependencies();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Vitalinguu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
