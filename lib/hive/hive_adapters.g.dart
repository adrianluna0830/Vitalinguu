// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class AppConfigurationAdapter extends TypeAdapter<AppConfiguration> {
  @override
  final typeId = 0;

  @override
  AppConfiguration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfiguration(
      geminiApiKey: fields[0] == null ? "" : fields[0] as String,
      microsoftApiKey: fields[1] == null ? "" : fields[1] as String,
      nativeLanguage: fields[2] == null ? "" : fields[2] as String,
      azure_region: fields[3] == null ? "" : fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfiguration obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.geminiApiKey)
      ..writeByte(1)
      ..write(obj.microsoftApiKey)
      ..writeByte(2)
      ..write(obj.nativeLanguage)
      ..writeByte(3)
      ..write(obj.azure_region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
