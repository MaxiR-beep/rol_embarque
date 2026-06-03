class Pasajero {
  final String apellido;
  final String nombre;
  final String dni;
  final String fechaNacimiento;
  final String nacionalidad;
  final String observaciones;

  Pasajero({
    required this.apellido,
    required this.nombre,
    required this.dni,
    this.fechaNacimiento = '',
    this.nacionalidad = '',
    this.observaciones = '',
  });

  factory Pasajero.fromJson(Map<String, dynamic> json) {
    return Pasajero(
      apellido: json['apellido'] ?? '',
      nombre: json['nombre'] ?? '',
      dni: json['dni'] ?? '',
      fechaNacimiento: json['fecha_nacimiento'] ?? '',
      nacionalidad: json['nacionalidad'] ?? '',
      observaciones: json['observaciones'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'apellido': apellido,
        'nombre': nombre,
        'dni': dni,
        'fecha_nacimiento': fechaNacimiento,
        'nacionalidad': nacionalidad,
        'observaciones': observaciones,
      };
}