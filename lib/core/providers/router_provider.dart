import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/core/constants/navigation_routes.dart';
import 'package:vitalingu/core/providers/global_configuration_provider.dart';
import 'package:vitalingu/features/language_selection/presentation/screens/language_selection_screen.dart';
import 'package:vitalingu/features/language_selection/presentation/screens/language_learning_screen.dart';
import 'package:vitalingu/features/configuration/presentation/screens/configuration_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final configService = ref.read(globalConfigurationProvider);
  
  return GoRouter(
    initialLocation: NavigationRoutes.chooseLanguageScreen,
    redirect: (context, state) async {
      final config = await configService.getOrCreateConfiguration();

      if (!config.isValid) {
        return NavigationRoutes.globalConfigurationScreen;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: NavigationRoutes.chooseLanguageScreen,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: NavigationRoutes.languageMainScreen,
        builder: (context, state) => LanguageLearningScreen(),
      ),
      GoRoute(
        path: NavigationRoutes.globalConfigurationScreen,
        builder: (context, state) => ConfigurationScreen(service: configService),
      ),
    ],
  );
});