import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:vitalingu/core/providers/router_provider.dart';
import 'package:vitalingu/hive/hive_registrar.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await Hive.initFlutter();
  Hive.registerAdapters();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}