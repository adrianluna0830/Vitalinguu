import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vitalinguu/core/settings/models/app_settings.dart';
import 'package:vitalinguu/core/storage/hive_storage.dart';

part 'settings_provider.g.dart';

class SettingsState {

}

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  final _storage = HiveStorage<AppSettings>();
  
  @override
  FutureOr<SettingsState> build() {
    throw UnimplementedError();
  }
  
}
