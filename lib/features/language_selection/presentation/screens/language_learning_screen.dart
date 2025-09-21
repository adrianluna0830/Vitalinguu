import 'package:flutter/material.dart';

class LanguageLearningScreen extends StatelessWidget {
  const LanguageLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language Main Screen")),
      body: Center(child: const Text("Ir al grabador de audio")),
    );
  }
}
