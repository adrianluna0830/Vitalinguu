import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalingu/core/constants/app_constants.dart';
import 'package:vitalingu/core/providers/config_providers.dart';

class MainConfigurationScreen extends ConsumerStatefulWidget {
  const MainConfigurationScreen({super.key});

  @override
  ConsumerState<MainConfigurationScreen> createState() => _MainConfigurationScreenState();
}

class _MainConfigurationScreenState extends ConsumerState<MainConfigurationScreen> {
  final _gemini = TextEditingController();
  final _microsoft = TextEditingController();
  final _form = GlobalKey<FormState>();
  
  String _language = 'en';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  _loadConfig() async {
    final config = await ref.read(configServiceProvider).getConfigOrNull();
    if (config != null && mounted) {
      _gemini.text = config.geminiApiKey;
      _microsoft.text = config.microsoftApiKey;
      _language = config.nativeLanguage.isEmpty ? 'en' : config.nativeLanguage;
      setState(() {});
    }
  }

  _save() async {
    if (!_form.currentState!.validate()) return;

    setState(() => _loading = true);
    
    await ref.read(configServiceProvider).updateCompleteConfig(
      geminiKey: _gemini.text.trim(),
      microsoftKey: _microsoft.text.trim(),
      nativeLanguage: _language,
    );
    
    context.go('/choose-language-screen');
  }

  String? _validate(String? value, String name) {
    if (value?.trim().isEmpty == true) return '$name requerida';
    if (value!.trim().length < 10) return '$name muy corta';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _gemini,
                decoration: const InputDecoration(labelText: "Gemini API Key"),
                validator: (v) => _validate(v, "Gemini Key"),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _microsoft,
                decoration: const InputDecoration(labelText: "Microsoft API Key"),
                validator: (v) => _validate(v, "Microsoft Key"),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _language,
                decoration: const InputDecoration(labelText: "Idioma"),
                items: supportedLanguages.entries.map((e) => 
                  DropdownMenuItem(value: e.key, child: Text(e.value))
                ).toList(),
                onChanged: (v) => setState(() => _language = v!),
              ),
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _save,
                  child: _loading 
                    ? const SizedBox(
                        width: 16, 
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Guardar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gemini.dispose();
    _microsoft.dispose();
    super.dispose();
  }
}