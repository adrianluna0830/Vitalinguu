import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/core/constants/navigation_routes.dart';
import 'package:vitalingu/core/providers/ai_service_notifier.dart';
import 'package:vitalingu/features/ai_generation/aplication/usecases/set_ai_generation.dart';
import 'package:vitalingu/core/providers/global_configuration_provider.dart';

class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends ConsumerState<LanguageSelectionScreen> {
  late Future<void> _setupFuture;

  @override
  void initState() {
    super.initState();
    _setupFuture = _initializeSetup();
  }

  Future<void> _initializeSetup() async {
    final config = await ref.read(globalConfigurationProvider).getOrCreateConfiguration();
    final aiServiceNotifier = ref.read(aiGenerationRepositoryProvider.notifier);
    return setUpAIGeneration(config, aiServiceNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              GoRouter.of(context).go(NavigationRoutes.globalConfigurationScreen);
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _setupFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else {
            return Center(
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).go(NavigationRoutes.languageMainScreen);
                },
                child: const Text("Start Learning"), 
              ),
            );
          }
        },
      ),
    );
  }
}