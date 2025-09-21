import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitalingu/core/constants/app_constants.dart';
import 'package:vitalingu/shared/data/models/app_configuration.dart';
import 'package:vitalingu/features/configuration/presentation/screens/configuration_service.dart';
import 'package:go_router/go_router.dart';

class RoutePaths {
  static const chooseLanguageScreen = '/language-selection';
  static const languageMainScreen = '/language-learning';
  static const globalConfigurationScreen = '/configuration';
}

class ConfigurationScreen extends ConsumerStatefulWidget {
  final ConfigurationService service;
  const ConfigurationScreen({super.key, required this.service});

  @override
  ConsumerState<ConfigurationScreen> createState() => _GlobalConfigurationMainScreen();
}

class _GlobalConfigurationMainScreen extends ConsumerState<ConfigurationScreen> {
  late TextEditingController _gemini;
  late TextEditingController _microsoft;
  late TextEditingController _azure;
  String? _lang;
  bool _showGemini = false;
  bool _showMicrosoft = false;
  AppConfiguration? _config;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final cfg = await widget.service.getOrCreateConfiguration();
    _gemini = TextEditingController(text: cfg.geminiApiKey);
    _microsoft = TextEditingController(text: cfg.microsoftApiKey);
    _azure = TextEditingController(text: cfg.azure_region);
    _lang = cfg.nativeLanguage.isNotEmpty ? cfg.nativeLanguage : supportedLanguages.keys.first;
    setState(() {
      _config = cfg;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _gemini.dispose();
    _microsoft.dispose();
    _azure.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: const Text("Global Configuration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildApiKeyField("Gemini API Key", _gemini, _showGemini, () => setState(() => _showGemini = !_showGemini)),
            _buildApiKeyField("Microsoft API Key", _microsoft, _showMicrosoft, () => setState(() => _showMicrosoft = !_showMicrosoft)),
            _buildTextField("Azure Region", _azure),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildApiKeyField(String label, TextEditingController controller, bool show, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: !show,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(show ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _lang,
      decoration: const InputDecoration(labelText: "Native Language"),
      items: supportedLanguages.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: (v) => setState(() => _lang = v),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_config == null) return;

        _config!
          ..geminiApiKey = _gemini.text
          ..microsoftApiKey = _microsoft.text
          ..azure_region = _azure.text
          ..nativeLanguage = _lang ?? '';
        await widget.service.saveConfiguration(_config!);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Configuration saved")),
          );
        }

        // Navegar usando la constante
        if (context.mounted) {
          GoRouter.of(context).go(RoutePaths.chooseLanguageScreen);
        }
      },
      child: const Text("Continue"),
    );
  }
}
