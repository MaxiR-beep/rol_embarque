import 'pasajero.dart';

class Viaje {
  final String id;
  final String fecha;
  final String hora;
  final String origen;
  final String destino;
  final String embarcacion;
  final String capitan;
  final List<Pasajero> pasajeros;
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

  factory Viaje.fromJson(Map<String, dynamic> json) {
    return Viaje(
      id: json['id'] ?? '',
      fecha: json['fecha'] ?? '',
      hora: json['hora'] ?? '',
      origen: json['origen'] ?? '',
      destino: json['destino'] ?? '',
      embarcacion: json['embarcacion'] ?? '',
      capitan: json['capitan'] ?? '',
      pasajeros: (json['pasajeros'] as List<dynamic>?)
              ?.map((p) => Pasajero.fromJson(p))
              .toList() ??
          [],
      observaciones: json['observaciones'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'fecha': fecha,
        'hora': hora,
        'origen': origen,
        'destino': destino,
        'embarcacion': embarcacion,
        'capitan': capitan,
        'observaciones': observaciones,
      };
}