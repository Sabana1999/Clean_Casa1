// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModel1Adapter extends TypeAdapter<ServiceModel1> {
  @override
  final int typeId = 4;

  @override
  ServiceModel1 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel1(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel1 obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.heading)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel1Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
