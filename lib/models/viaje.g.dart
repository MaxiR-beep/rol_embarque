// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viaje.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViajeAdapter extends TypeAdapter<Viaje> {
  @override
  final int typeId = 1;

  @override
  Viaje read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Viaje(
      id: fields[0] as String,
      fecha: fields[1] as String,
      hora: fields[2] as String,
      origen: fields[3] as String,
      destino: fields[4] as String,
      embarcacion: fields[5] as String,
      capitan: fields[6] as String,
      pasajeros: (fields[7] as List).cast<Pasajero>(),
      observaciones: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Viaje obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fecha)
      ..writeByte(2)
      ..write(obj.hora)
      ..writeByte(3)
      ..write(obj.origen)
      ..writeByte(4)
      ..write(obj.destino)
      ..writeByte(5)
      ..write(obj.embarcacion)
      ..writeByte(6)
      ..write(obj.capitan)
      ..writeByte(7)
      ..write(obj.pasajeros)
      ..writeByte(8)
      ..write(obj.observaciones);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViajeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
