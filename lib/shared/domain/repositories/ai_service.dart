import 'dart:typed_data';

abstract class AIService {
  Future<String> generateTextResponse(String prompt);
  Future<String> generateChatResponse(List<Map<String, String>> history);
  Future<Uint8List> convertTextToAudio(String text, String voice);
  Future<Uint8List> convertSsmlToAudio(String ssml);
  Future<String> transcribeAudio(Uint8List audioData, String locale);
  Future<Map<String, dynamic>> evaluatePronunciation(Uint8List audioData,String languageCode,{String? referenceText});
}
