import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:vitalingu/core/providers/ai_service_notifier.dart';
import 'package:vitalingu/features/ai_generation/data/http_ai_service.dart';
import 'package:vitalingu/shared/data/models/app_configuration.dart'; 

Future<int> getUnusedPort(InternetAddress address) {
  return ServerSocket.bind(address, 0).then((socket) {
    final port = socket.port;
    socket.close();
    return port;
  });
}

Future<void> _startAIGenerationServer(
  AppConfiguration app_configuration, {
  required String port,
}) async {
  late String relativeExePath = "";
  if (Platform.isLinux) {
    relativeExePath = p.join('python_server', 'linux', 'main');
  } else if (Platform.isWindows) {
    relativeExePath = p.join('python_server', 'windows', 'main.exe');
  }

  final currentDirectory = Directory.current.path;
  final exePath = p.join(currentDirectory, relativeExePath);

  if (!File(exePath).existsSync()) {
    throw Exception("Executable not found at: $exePath");
  }

  final environmentVariables = {
    'GOOGLE_API_KEY': app_configuration.geminiApiKey,
    'AZURE_SUBSCRIPTION_KEY': app_configuration.microsoftApiKey,
    'AZURE_REGION': app_configuration.azure_region,
    'HOST': 'localhost',
    'PORT': port,
  };

  try {
    await Process.start(
      exePath,
      [],
      environment: environmentVariables,
    );
  } catch (e) {
    throw Exception(
      'Error starting the AI server process: $e',
    );
  }
}

Future<void> _waitForServerReady({
  required String host,
  required String port,
  int attempts = 10,
  int delay = 1000,
}) async {
  final healthCheckUrl = Uri.http('$host:$port', '/server-status');

  for (int attempt = 1; attempt <= attempts; attempt++) {
    await Future.delayed(
      Duration(milliseconds: delay),
    );
    try {
      final healthResponse = await http.get(healthCheckUrl);
      if (healthResponse.statusCode == 200) {
        return;
      }
    } catch (e) {
      // Manejo de errores
    }
  }
  
  throw Exception(
    'The AI server did not respond to the health check after ${attempts} attempts.',
  );
}

Future<void> setUpAIGeneration(AppConfiguration app_configuration,AIServiceNotifier aiServiceNotifier) async {
  const String host = 'localhost';
  
  final int freePort = await getUnusedPort(InternetAddress.loopbackIPv4); 
  final String port = freePort.toString();
  
  await _startAIGenerationServer(
    app_configuration,
    port: port,
  );
  
  await _waitForServerReady(
    host: host, 
    port: port,
  );

  aiServiceNotifier.setRepository(  
    HttpAIService(
      baseUrl: host,
      port: port,
    ),
  );

  
}