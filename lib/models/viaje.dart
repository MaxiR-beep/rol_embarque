import 'package:hive/hive.dart';

import 'pasajero.dart';

part 'viaje.g.dart';

@HiveType(typeId: 1)
class Viaje {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fecha;

  @HiveField(2)
  final String hora;

  @HiveField(3)
  final String origen;

  @HiveField(4)
  final String destino;

  @HiveField(5)
  final String embarcacion;

  @HiveField(6)
  final String capitan;

  @HiveField(7)
  final List<Pasajero> pasajeros;

  @HiveField(8)
  final String observaciones;

  Viaje({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.origen,
    required this.destino,
    required this.embarcacion,
    required this.capitan,
    required this.pasajeros,
    required this.observaciones,
  });
}
