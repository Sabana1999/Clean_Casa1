// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db4.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModel3Adapter extends TypeAdapter<ServiceModel3> {
  @override
  final int typeId = 6;

  @override
  ServiceModel3 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel3(
      fields[0] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel3 obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel3Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
