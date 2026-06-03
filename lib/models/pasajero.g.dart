// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pasajero.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasajeroAdapter extends TypeAdapter<Pasajero> {
  @override
  final int typeId = 0;

  @override
  Pasajero read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pasajero(
      apellido: fields[0] as String,
      nombre: fields[1] as String,
      dni: fields[2] as String,
      fechaNacimiento: fields[3] as String,
      nacionalidad: fields[4] as String,
      observaciones: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pasajero obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.apellido)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.dni)
      ..writeByte(3)
      ..write(obj.fechaNacimiento)
      ..writeByte(4)
      ..write(obj.nacionalidad)
      ..writeByte(5)
      ..write(obj.observaciones);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasajeroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
