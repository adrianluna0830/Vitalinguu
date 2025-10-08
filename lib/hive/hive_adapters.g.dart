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
      nativeLanguage: fields[0] as LanguageData,
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

class LanguageLocalAdapter extends TypeAdapter<LanguageLocal> {
  @override
  final typeId = 3;

  @override
  LanguageLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageLocal(
      localCode: fields[0] as String,
      locale: fields[1] as String,
      pronunciationAssessmentSupported: fields[2] as bool,
      fastApiSupported: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageLocal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.localCode)
      ..writeByte(1)
      ..write(obj.locale)
      ..writeByte(2)
      ..write(obj.pronunciationAssessmentSupported)
      ..writeByte(3)
      ..write(obj.fastApiSupported);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageDataAdapter extends TypeAdapter<LanguageData> {
  @override
  final typeId = 4;

  @override
  LanguageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageData(
      languageCode: fields[0] as String,
      languageLocal: (fields[1] as List).cast<LanguageLocal>(),
    );
  }

  @override
  void write(BinaryWriter writer, LanguageData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.languageCode)
      ..writeByte(1)
      ..write(obj.languageLocal);
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
