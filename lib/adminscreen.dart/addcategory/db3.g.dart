// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db3.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModel2Adapter extends TypeAdapter<ServiceModel2> {
  @override
  final int typeId = 5;

  @override
  ServiceModel2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel2(
      fields[0] as String,
      fields[1] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel2 obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.service)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
