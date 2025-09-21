import 'dart:io';
import 'dart:async';
import 'package:vitalingu/core/providers/ai_service_notifier.dart';
import 'package:vitalingu/shared/data/models/app_configuration.dart';
import 'package:vitalingu/features/ai_generation/domain/services/start_serious_python_server_service.dart';
import 'package:vitalingu/features/ai_generation/http_ai_service_repository.dart';


Future<void> setupAIGenerationUsecase(
  AIServiceNotifier container,
  AppConfiguration config,
) async {
  if (Platform.isLinux || Platform.isWindows) {
    final success = await startSeriousPythonServerService(
      zipPath: "app/app.zip",
      mainFileName: "main.py",
      environmentVariables: {
        "GOOGLE_API_KEY": config.geminiApiKey,
        "AZURE_SUBSCRIPTION_KEY": config.microsoftApiKey,
        "AZURE_REGION": config.azure_region,
      },
      maxAttempts: 5
    );

    if (!success) {
      throw Exception("No se pudo iniciar el servidor Flask con SeriousPython.");
    }

    container.setRepository(HttpAIServiceRepository(baseUrl: "http://localhost:5000"));
  }
}
