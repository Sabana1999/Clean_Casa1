// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db5.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModel4Adapter extends TypeAdapter<ServiceModel4> {
  @override
  final int typeId = 7;

  @override
  ServiceModel4 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel4(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel4 obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.details1)
      ..writeByte(1)
      ..write(obj.details2)
      ..writeByte(2)
      ..write(obj.service);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel4Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
