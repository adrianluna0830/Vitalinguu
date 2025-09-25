import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vitalingu/core/constants/vitalingu_api_endpoints.dart';
import 'package:vitalingu/shared/domain/repositories/ai_service.dart';

class VitalinguAIException implements Exception {
  final String message;
  final int statusCode;
  VitalinguAIException(this.message, this.statusCode);

  @override
  String toString() => 'VitalinguAIException: $message (Status: $statusCode)';
}

class HttpAIService implements AIService {
  final String baseUrl;
  final String port;
  late final http.Client _client;

  HttpAIService({required this.baseUrl, required this.port}) {
    _client = http.Client();
  }

  Uri _getUrl(String endpoint, [Map<String, dynamic>? queryParams]) {
    final Map<String, dynamic> finalParams = queryParams ?? {};
    return Uri.http('$baseUrl:$port', endpoint, finalParams);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.headers['content-type']?.contains('audio') == true ||
          response.headers['content-type']?.contains('text/plain') == true) {
        return response.bodyBytes;
      }
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      final errorMessage = errorBody['error'] ?? 'An unknown error occurred';
      throw VitalinguAIException(errorMessage, response.statusCode);
    }
  }

  @override
  Future<Uint8List> convertSsmlToAudio(String ssml) async {
    final url = _getUrl(VitalinguApiEndpoints.ssmlToSpeech);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'ssml': ssml}),
    );
    return _handleResponse(response) as Uint8List;
  }

  @override
  Future<Uint8List> convertTextToAudio(String text, String voice) async {
    final url = _getUrl(VitalinguApiEndpoints.textToSpeech);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'text': text, 'voice': voice}),
    );
    return _handleResponse(response) as Uint8List;
  }

  @override
  Future<Map<String, dynamic>> evaluatePronunciation(
      Uint8List audioData, String languageCode,
      {String? referenceText}) async {
    final queryParams = {
      'language': languageCode,
      if (referenceText != null) 'reference_text': referenceText,
    };
    final url = _getUrl(VitalinguApiEndpoints.pronunciationAssessment, queryParams);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'audio/wav'},
      body: audioData,
    );
    return _handleResponse(response) as Map<String, dynamic>;
  }

  @override
  Future<String> generateChatResponse(List<Map<String, String>> history) async {
    final url = _getUrl(VitalinguApiEndpoints.chatGeneration);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'history': history}),
    );
    final jsonResponse = _handleResponse(response) as Map<String, dynamic>;
    return jsonResponse['response'] as String;
  }

  @override
  Future<String> generateTextResponse(String prompt) async {
    final url = _getUrl(VitalinguApiEndpoints.textGeneration);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'prompt': prompt}),
    );
    final jsonResponse = _handleResponse(response) as Map<String, dynamic>;
    if (jsonResponse.containsKey('response')) {
      final innerResponse = jsonResponse['response'];
      if (innerResponse is Map<String, dynamic>) {
        return json.encode(innerResponse);
      }
      return innerResponse.toString();
    }
    return jsonEncode(jsonResponse);
  }

  @override
  Future<String> transcribeAudio(Uint8List audioData, String locale) async {
    final queryParams = {'locale': locale};
    final url = _getUrl(VitalinguApiEndpoints.fastTranscription, queryParams);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'audio/wav'},
      body: audioData,
    );
    return utf8.decode(_handleResponse(response) as Uint8List);
  }
}