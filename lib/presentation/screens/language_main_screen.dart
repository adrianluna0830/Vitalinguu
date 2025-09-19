import 'package:flutter/material.dart';

class LanguageMainScreen extends StatelessWidget {
  const LanguageMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Main Screen"),
      ),
      body: const Center(
        child: Text("Language Main Screen"),
      ),
    );
  }
}