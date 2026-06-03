import 'package:hive/hive.dart';

part 'pasajero.g.dart';

@HiveType(typeId: 0)
class Pasajero {
  @HiveField(0)
  final String apellido;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String dni;

  @HiveField(3)
  final String fechaNacimiento;

  @HiveField(4)
  final String nacionalidad;

  @HiveField(5)
  final String observaciones;

  Pasajero({
    required this.apellido,
    required this.nombre,
    required this.dni,
    required this.fechaNacimiento,
    required this.nacionalidad,
    required this.observaciones,
  });
}
