import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/language_data/models/language_local.dart';
import 'package:vitalinguu/core/navigation/navigation_service.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/settings/view_models/settings_view_model.dart';
import 'package:vitalinguu/injection.dart';

@RoutePage()
class SettingsView extends StatefulWidget implements AutoRouteWrapper {
  const SettingsView({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsViewModel>(),
      child: this,
    );
  }

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _geminiController = TextEditingController();
  final _microsoftApiKeyController = TextEditingController();
  final _microsoftRegionController = TextEditingController();

  LanguageData? _selectedLanguage;
  LanguageLocal? _selectedLocal;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<SettingsViewModel>();
    final currentSettings = viewModel.state.appSettings;

    _geminiController.text = currentSettings.geminiApiKey;
    _microsoftApiKeyController.text = currentSettings.microsoftApiKey;
    _microsoftRegionController.text = currentSettings.microsoftRegion;

    final savedLanguage = currentSettings.nativeLanguage;
    if (savedLanguage.isValid) {
      final matchingLanguage = viewModel.state.languages.firstWhere(
        (lang) => lang.languageCode == savedLanguage.languageCode,
        orElse: () => LanguageData(languageCode: '', languageLocal: []),
      );

      if (matchingLanguage.isValid) {
        _selectedLanguage = matchingLanguage;
        if (savedLanguage.languageLocal.isNotEmpty) {
          final matchingLocale = matchingLanguage.languageLocal.firstWhere(
            (local) => local.localCode == savedLanguage.languageLocal.first.localCode,
            orElse: () => matchingLanguage.languageLocal.first,
          );
          _selectedLocal = matchingLocale;
        } else if (matchingLanguage.languageLocal.isNotEmpty) {
          _selectedLocal = matchingLanguage.languageLocal.first;
        }
      }
    }
  }

  @override
  void dispose() {
    _geminiController.dispose();
    _microsoftApiKeyController.dispose();
    _microsoftRegionController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    final viewModel = context.read<SettingsViewModel>();

    if (_selectedLanguage == null || _selectedLocal == null) {
      _showError('Please select a language and locale');
      return;
    }

    final newSettings = AppSettings(
      nativeLanguage: _selectedLanguage!,
      geminiApiKey: _geminiController.text,
      microsoftApiKey: _microsoftApiKeyController.text,
      microsoftRegion: _microsoftRegionController.text,
    );

    await viewModel.updateAppSettings(newSettings);

    if (viewModel.state.isValid) {
      if (mounted) {
        _showSuccess('Settings saved successfully!');
        // Usar NavigationService en lugar de navegar directamente desde el widget
        await getIt<NavigationService>().replaceWithLanguageSelection();
      }
    } else {
      _showError('Please fill all required fields');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsViewModel, SettingsState>(
        builder: (context, state) {
          final languages = state.languages;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Language Configuration Section
                const Text(
                  'Language Configuration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                LanguageDropdown(
                  selectedLanguage: _selectedLanguage,
                  languages: languages,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value;
                      if (value != null && value.languageLocal.isNotEmpty) {
                        _selectedLocal = value.languageLocal.first;
                      } else {
                        _selectedLocal = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),

                if (_selectedLanguage != null && _selectedLanguage!.languageLocal.isNotEmpty) ...[
                  LocaleDropdown(
                    selectedLocal: _selectedLocal,
                    locales: _selectedLanguage!.languageLocal,
                    onChanged: (value) {
                      setState(() {
                        _selectedLocal = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                ],

                // API Configuration Section
                const Text(
                  'API Configuration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Gemini API Key
                TextField(
                  controller: _geminiController,
                  decoration: const InputDecoration(
                    labelText: 'Gemini API Key',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Gemini API Key',
                  ),
                ),
                const SizedBox(height: 16),

                // Microsoft API Key
                TextField(
                  controller: _microsoftApiKeyController,
                  decoration: const InputDecoration(
                    labelText: 'Microsoft API Key',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Microsoft API Key',
                  ),
                ),
                const SizedBox(height: 16),

                // Microsoft Region
                TextField(
                  controller: _microsoftRegionController,
                  decoration: const InputDecoration(
                    labelText: 'Microsoft Region',
                    border: OutlineInputBorder(),
                    hintText: 'e.g., eastus, westeurope',
                  ),
                ),
                const SizedBox(height: 24),

                // Save Button
                ElevatedButton(
                  onPressed: _saveSettings,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Save and Continue',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  final LanguageData? selectedLanguage;
  final List<LanguageData> languages;
  final ValueChanged<LanguageData?> onChanged;

  const LanguageDropdown({
    super.key,
    required this.selectedLanguage,
    required this.languages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<LanguageData>(
      decoration: const InputDecoration(
        labelText: 'Select Language',
        border: OutlineInputBorder(),
      ),
      initialValue: selectedLanguage?.isValid == true ? selectedLanguage : null,
      items: languages.map((lang) {
        return DropdownMenuItem(
          value: lang,
          child: Text(lang.languageCode),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class LocaleDropdown extends StatelessWidget {
  final LanguageLocal? selectedLocal;
  final List<LanguageLocal> locales;
  final ValueChanged<LanguageLocal?> onChanged;

  const LocaleDropdown({
    super.key,
    required this.selectedLocal,
    required this.locales,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<LanguageLocal>(
      decoration: const InputDecoration(
        labelText: 'Select Locale',
        border: OutlineInputBorder(),
      ),
      initialValue: selectedLocal,
      items: locales.map((local) {
        return DropdownMenuItem(
          value: local,
          child: Text('${local.locale} (${local.localCode})'),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}