import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vitalinguu/core/navigation/routes.dart';
import 'package:vitalinguu/core/settings/models/settings_state.dart';
import 'package:vitalinguu/core/settings/view_models/settings_view_model.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      onChanged: onChanged,
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}

class _SettingsViewState extends State<SettingsView> {
  final _geminiController = TextEditingController();
  final _microsoftApiKeyController = TextEditingController();
  final _microsoftRegionController = TextEditingController();
  bool _isInitialized = false;

  @override
  void dispose() {
    _geminiController.dispose();
    _microsoftApiKeyController.dispose();
    _microsoftRegionController.dispose();
    super.dispose();
  }

  void _initializeFromState(SettingsState state) {
    if (!_isInitialized && !state.isLoading) {
      _geminiController.text = state.geminiApiKey;
      _microsoftApiKeyController.text = state.microsoftApiKey;
      _microsoftRegionController.text = state.microsoftRegion;
      _isInitialized = true;
    }
  }

  Widget _buildLanguageDropdown(SettingsViewModel viewModel, List<String> uniqueLanguages) {
    return BlocBuilder<SettingsViewModel, SettingsState>(
      builder: (context, state) {
        return CustomDropdown<String>(
          label: 'Select Language',
          value: state.selectedLanguageName,
          items: uniqueLanguages.map((lang) {
            return DropdownMenuItem(
              value: lang,
              child: Text(lang),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.selectLanguage(value);
            }
          },
        );
      },
    );
  }

  Widget _buildLocaleDropdown(SettingsViewModel viewModel, List<String> availableLocales) {
    return BlocBuilder<SettingsViewModel, SettingsState>(
      builder: (context, state) {
        return CustomDropdown<String>(
          label: 'Select Locale',
          value: state.selectedLanguage?.locale,
          items: availableLocales.map((locale) {
            return DropdownMenuItem(
              value: locale,
              child: Text(locale),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.selectLocale(value);
            }
          },
        );
      },
    );
  }

  Widget _buildApiConfiguration(SettingsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _geminiController,
          label: 'Gemini API Key',
          hint: 'Enter your Gemini API Key',
          onChanged: viewModel.updateGeminiApiKey,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _microsoftApiKeyController,
          label: 'Microsoft API Key',
          hint: 'Enter your Microsoft API Key',
          onChanged: viewModel.updateMicrosoftApiKey,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _microsoftRegionController,
          label: 'Microsoft Region',
          hint: 'e.g., eastus, westeurope',
          onChanged: viewModel.updateMicrosoftRegion,
        ),
      ],
    );
  }

  Widget _buildSaveButton(SettingsViewModel viewModel) {
    return ElevatedButton(
      onPressed: () async {
        final result = await viewModel.saveSettings();

        result.fold(
          (exception) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(exception.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings saved successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              const LanguageSelectionRoute().go(context);
            }
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text(
        'Save and Continue',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocConsumer<SettingsViewModel, SettingsState>(
        listener: (context, state) {
          _initializeFromState(state);
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final viewModel = context.read<SettingsViewModel>();
          final uniqueLanguages = viewModel.uniqueLanguages;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Language Configuration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildLanguageDropdown(viewModel, uniqueLanguages),
                const SizedBox(height: 8),
                if (state.selectedLanguage != null && state.selectedLanguage!.locale.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Selected: ${state.selectedLanguageName} (${state.selectedLanguage!.locale})',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (state.availableLocales.isNotEmpty) ...[
                  _buildLocaleDropdown(viewModel, state.availableLocales),
                  const SizedBox(height: 24),
                ],
                const Text(
                  'API Configuration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildApiConfiguration(viewModel),
                const SizedBox(height: 24),
                _buildSaveButton(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }
}
