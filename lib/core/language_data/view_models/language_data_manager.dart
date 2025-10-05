import 'package:injectable/injectable.dart';
import 'package:vitalinguu/core/constants/language_supported_features.dart';
import 'package:vitalinguu/core/language_data/models/language_data.dart';
import 'package:vitalinguu/core/storage/storage_interface.dart';
import 'package:vitalinguu/injection.dart';


@lazySingleton
class LanguageDataManager {
  final _storage = getIt<StorageInterface<LanguageData>>();

  Future<List<LanguageData>> loadAllLanguages() async {
    final count = await _storage.count(); 
    if (count > 0) {
      return await _storage.getAll();
    }
    else
    {
      final languages = languageDataList;
      for (var lang in languages) {
        await _storage.save(lang);
      }
      return languages;
    }
  }

}
