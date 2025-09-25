import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitalingu/shared/domain/repositories/ai_service.dart';

class AIServiceNotifier extends Notifier<AIService?> {
  @override
  AIService? build() => null; 

  void setRepository(AIService repo) {
    state = repo;
  }
}

final aiGenerationRepositoryProvider =
    NotifierProvider<AIServiceNotifier, AIService?>(
        AIServiceNotifier.new);
