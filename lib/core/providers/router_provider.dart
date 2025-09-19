import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/core/providers/config_providers.dart';
import 'package:vitalingu/presentation/screens/choose_language_screen.dart';
import 'package:vitalingu/presentation/screens/language_main_screen.dart';
import 'package:vitalingu/presentation/screens/main_configuration_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final configService = ref.read(configServiceProvider);
  
  return GoRouter(
    initialLocation: '/choose-language-screen',
    redirect: (context, state) async {
      final hasConfig = await configService.hasConfiguration();
      final isConfigValid = hasConfig ? await configService.isConfigurationValid() : false;

      if (!hasConfig || !isConfigValid) {
        if (state.fullPath != '/main-configuration-screen') {
          return '/main-configuration-screen';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/choose-language-screen',
        builder: (context, state) => const ChooseLanguageScreen(),
      ),
      GoRoute(
        path: '/language-main-screen',
        builder: (context, state) => const LanguageMainScreen(),
      ),
      GoRoute(
        path: '/main-configuration-screen',
        builder: (context, state) => const MainConfigurationScreen(),
      ),
    ],
  );
});