import 'package:serious_python/serious_python.dart';
import 'package:vitalingu/features/ai_generation/domain/services/wait_for_server_readiness_service.dart';

Future<bool> startSeriousPythonServerService({
  required String zipPath,
  required String mainFileName,
  required Map<String, String> environmentVariables,
  String baseUrl = "http://localhost:5000",
  int maxAttempts = 5,
  Duration delayBetweenAttempts = const Duration(seconds: 1),
}) async {
  try {
    SeriousPython.run(
      zipPath,
      appFileName: mainFileName,
      environmentVariables: environmentVariables,
    );

    final ready = await waitForServerReadinessService(
      baseUrl: baseUrl,
      maxAttempts: maxAttempts,
      delayBetweenAttempts: delayBetweenAttempts,
    );
    return ready;
  } catch (_) {
    return false;
  }
}
