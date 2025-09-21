import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitalingu/shared/domain/repositories/ai_generation_repository.dart';

class AIServiceNotifier extends Notifier<AIGenerationRepository?> {
  @override
  AIGenerationRepository? build() => null; 

  void setRepository(AIGenerationRepository repo) {
    state = repo;
  }
}

final aiGenerationRepositoryProvider =
    NotifierProvider<AIServiceNotifier, AIGenerationRepository?>(
        AIServiceNotifier.new);
