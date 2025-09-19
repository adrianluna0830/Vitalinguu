// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class GlobalConfigurationAdapter extends TypeAdapter<GlobalConfiguration> {
  @override
  final typeId = 0;

  @override
  GlobalConfiguration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalConfiguration()
      ..geminiApiKey = fields[0] as String
      ..microsoftApiKey = fields[1] as String
      ..nativeLanguage = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, GlobalConfiguration obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.geminiApiKey)
      ..writeByte(1)
      ..write(obj.microsoftApiKey)
      ..writeByte(2)
      ..write(obj.nativeLanguage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalConfigurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
