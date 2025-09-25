import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentSessionConfigurationProvider = NotifierProvider<CurrentSessionNotifier, CurrentSessionConfiguration?>(
    CurrentSessionNotifier.new);

class CurrentSessionConfiguration {
  final int port;

  const CurrentSessionConfiguration({this.port = 8000});

}
class CurrentSessionNotifier extends Notifier<CurrentSessionConfiguration?> {
  @override
  CurrentSessionConfiguration? build() {
    return CurrentSessionConfiguration();
  }

    void replaceState(CurrentSessionConfiguration nuevoEstado) {
        state = nuevoEstado;
    }
}
