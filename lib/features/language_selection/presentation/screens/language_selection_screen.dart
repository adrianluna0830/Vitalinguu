import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/core/providers/ai_service_notifier.dart';
import 'package:vitalingu/features/ai_generation/data/repositories/ai_generation_setup_usecase.dart';
import 'package:vitalingu/features/configuration/presentation/screens/configuration_screen.dart';
import 'package:vitalingu/core/providers/global_configuration_provider.dart';


class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends ConsumerState<LanguageSelectionScreen> {
  late Future<void> _setupFuture;

  @override
  void initState() {
    super.initState();
    _setupFuture = _setupAIGeneration();
  }

  Future<void> _setupAIGeneration() async {
    final aiRepoNotifier = ref.read(aiGenerationRepositoryProvider.notifier);
    final configService = ref.read(globalConfigurationProvider);
    final config = await configService.getOrCreateConfiguration();
    if (!config.isValid) {
      throw Exception("Configuration is not valid");
    }

    await setupAIGenerationUsecase(aiRepoNotifier, config);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                GoRouter.of(context).go(RoutePaths.globalConfigurationScreen),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _setupFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return Center(
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).go(RoutePaths.languageMainScreen);
                },
                child: const Text("Mock"),
              ),
            );
          }
        },
      ),
    );
  }
}
