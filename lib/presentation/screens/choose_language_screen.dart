import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/presentation/widgets/config_dialog.dart';

class ChooseLanguageScreen extends ConsumerWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const ConfigDialog(),
            ),
          ),
        ],
      ),
      body: TextButton(onPressed: () {GoRouter.of(context).go('/language-main-screen');}, child: const Text("Mock")),
    );
  }
}