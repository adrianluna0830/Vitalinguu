import 'dart:async';
import 'package:http/http.dart' as http;


Future<bool> waitForServerReadinessService({
  required String baseUrl,
  int maxAttempts = 10,
  Duration delayBetweenAttempts = const Duration(seconds: 1),
}) async {
  var attempts = 0;
  while (attempts < maxAttempts) {
    attempts++;
    try {
      final response = await http.get(Uri.parse('$baseUrl/health'));
      if (response.statusCode == 200) return true;
    } catch (_) {}
    await Future.delayed(delayBetweenAttempts);
  }
  return false;
}
