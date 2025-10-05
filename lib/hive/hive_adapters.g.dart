// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final typeId = 0;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      nativeLanguage: fields[0] as String,
      geminiApiKey: fields[1] as String,
      microsoftApiKey: fields[2] as String,
      microsoftRegion: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nativeLanguage)
      ..writeByte(1)
      ..write(obj.geminiApiKey)
      ..writeByte(2)
      ..write(obj.microsoftApiKey)
      ..writeByte(3)
      ..write(obj.microsoftRegion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageDataAdapter extends TypeAdapter<LanguageData> {
  @override
  final typeId = 1;

  @override
  LanguageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageData(
      fastApiSupported: fields[0] as bool,
      languageCode: fields[1] as String,
      languageName: fields[2] as String,
      locale: fields[3] as String,
      pronunciationAssessmentSupported: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fastApiSupported)
      ..writeByte(1)
      ..write(obj.languageCode)
      ..writeByte(2)
      ..write(obj.languageName)
      ..writeByte(3)
      ..write(obj.locale)
      ..writeByte(4)
      ..write(obj.pronunciationAssessmentSupported);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageProgressDataAdapter extends TypeAdapter<LanguageProgressData> {
  @override
  final typeId = 2;

  @override
  LanguageProgressData read(BinaryReader reader) {
    reader.readByte();
    return LanguageProgressData();
  }

  @override
  void write(BinaryWriter writer, LanguageProgressData obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageProgressDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
