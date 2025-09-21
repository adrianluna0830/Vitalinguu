import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:vitalingu/shared/domain/repositories/ai_generation_repository.dart';

class HttpAIServiceRepository implements AIGenerationRepository {
  final String baseUrl;

  HttpAIServiceRepository({required this.baseUrl});

  @override
  Future<String> generateTextResponse(String prompt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/text-generation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? '';
    } else {
      throw Exception('Failed to generate text: ${response.body}');
    }
  }

  @override
  Future<String> generateChatResponse(List<Map<String, String>> history) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat-generation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'history': history}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? '';
    } else {
      throw Exception('Failed to generate chat: ${response.body}');
    }
  }

  @override
  Future<Uint8List> convertTextToAudio(String text, String voice) async {
    final response = await http.post(
      Uri.parse('$baseUrl/text-to-speech'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text, 'voice': voice}),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Text-to-speech failed: ${response.body}');
    }
  }

  @override
  Future<Uint8List> convertSsmlToAudio(String ssml) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ssml-to-speech'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ssml': ssml}),
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('SSML-to-speech failed: ${response.body}');
    }
  }

  @override
  Future<String> transcribeAudio(Uint8List audioData, String locale) async {
    final response = await http.post(
      Uri.parse('$baseUrl/fast-transcription?locale=$locale'),
      headers: {'Content-Type': 'application/octet-stream'},
      body: audioData,
    );

    if (response.statusCode == 200) {
      // La API devuelve un archivo SRT
      return utf8.decode(response.bodyBytes);
    } else {
      throw Exception('Audio transcription failed: ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> evaluatePronunciation(
      Uint8List audioData, String languageCode,
      {String? referenceText}) async {
    final queryParams = referenceText != null
        ? '?language=$languageCode&reference_text=${Uri.encodeComponent(referenceText)}'
        : '?language=$languageCode';

    final response = await http.post(
      Uri.parse('$baseUrl/pronunciation-assessment$queryParams'),
      headers: {'Content-Type': 'application/octet-stream'},
      body: audioData,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Pronunciation assessment failed: ${response.body}');
    }
  }
}
