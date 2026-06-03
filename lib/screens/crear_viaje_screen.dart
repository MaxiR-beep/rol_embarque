import 'package:flutter/material.dart';
import '../models/pasajero.dart';
import '../models/viaje.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CrearViajeScreen extends StatefulWidget {
  final Function(Viaje) onGuardar;
  final Viaje? viaje;

  const CrearViajeScreen({super.key, required this.onGuardar, this.viaje});
  @override
  State<CrearViajeScreen> createState() => _CrearViajeScreenState();
}

class _CrearViajeScreenState extends State<CrearViajeScreen> {
  final TextEditingController origenController = TextEditingController();
  final TextEditingController destinoController = TextEditingController();
  final TextEditingController embarcacionController = TextEditingController();
  final TextEditingController capitanController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController pasajerosController = TextEditingController();
  final TextEditingController observacionesController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController fechaNacimientoController =
      TextEditingController();
  final TextEditingController nacionalidadController = TextEditingController();
  final TextEditingController observacionesPasajeroController =
      TextEditingController();

  List<Pasajero> pasajeros = [];

  String? rutaSeleccionada;
  String? embarcacionSeleccionada;

  final List<String> rutas = [
    'Puerto Ituzaingó → Puerto Apipé Grande',
    'Puerto Apipé Grande → Puerto Ituzaingó',
  ];

  final List<String> embarcaciones = [
    'Alfonsina I',
    'Alfonsina II',
    'El Correntino I',
    'El Correntino II',
    'El Correntino III',
  ];
  final List<String> capitanes = [
    'Diaz Raul Adolfo',
    'Sena Walter Elias',
    'Ojeda Jose Leopoldo',
    'Almiron Diego Ariel',
    'Benitez Hugo Cesar',
    'Dominguez Gonzalo Rafael',
    'Figueredo Gustavo Ronaldo',
  ];
  final List<String> horarios = [
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '12:30',
    '13:00',
    '14:00',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.viaje != null) {
      rutaSeleccionada = '${widget.viaje!.origen} → ${widget.viaje!.destino}';

      embarcacionSeleccionada = widget.viaje!.embarcacion;

      capitanController.text = widget.viaje!.capitan;

      horaController.text = widget.viaje!.hora;

      observacionesController.text = widget.viaje!.observaciones;

      pasajeros = List.from(widget.viaje!.pasajeros);
    }
  }

  void agregarPasajero() {
    if (apellidoController.text.trim().isEmpty ||
        nombreController.text.trim().isEmpty ||
        dniController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Datos incompletos'),
          content: const Text('Debe completar apellido, nombre y DNI.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );

      return;
    }
    final dniExiste = pasajeros.any((p) => p.dni == dniController.text);

    if (dniExiste) {
      showDialog(
        context: context,

        builder: (context) => AlertDialog(
          title: const Text('Pasajero duplicado'),

          content: const Text('Ese DNI ya fue agregado en este viaje.'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Aceptar'),
            ),
          ],
        ),
      );

      return;
    }
    final pasajero = Pasajero(
      apellido: apellidoController.text,
      nombre: nombreController.text,
      dni: dniController.text,
      fechaNacimiento: fechaNacimientoController.text,
      nacionalidad: nacionalidadController.text,
      observaciones: observacionesPasajeroController.text,
    );

    setState(() {
      pasajeros.add(pasajero);
    });

    final boxPasajeros = Hive.box<Pasajero>('pasajeros');

    boxPasajeros.put(pasajero.dni, pasajero);

    apellidoController.clear();
    nombreController.clear();
    dniController.clear();
    fechaNacimientoController.clear();
    nacionalidadController.clear();
    observacionesPasajeroController.clear();
  }

  void eliminarPasajero(int index) {
    setState(() {
      pasajeros.removeAt(index);
    });
  }

  void buscarPasajeroPorDni(String dni) {
    final boxPasajeros = Hive.box<Pasajero>('pasajeros');

    final pasajero = boxPasajeros.get(dni);

    if (pasajero != null) {
      apellidoController.text = pasajero.apellido;

      nombreController.text = pasajero.nombre;

      fechaNacimientoController.text = pasajero.fechaNacimiento;

      nacionalidadController.text = pasajero.nacionalidad;

      observacionesPasajeroController.text = pasajero.observaciones;
    }
  }

  void guardarViaje() {
    final viaje = Viaje(
      id: widget.viaje?.id ?? DateTime.now().toString(),
      fecha: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      hora: horaController.text,
      origen: rutaSeleccionada?.split('→')[0].trim() ?? '',
      destino: rutaSeleccionada?.split('→')[1].trim() ?? '',
      embarcacion: embarcacionSeleccionada ?? '',
      capitan: capitanController.text,
      pasajeros: pasajeros,
      observaciones: observacionesController.text,
    );

    widget.onGuardar(viaje);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Viaje')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              initialValue: rutaSeleccionada,

              decoration: const InputDecoration(labelText: 'Ruta'),

              items: rutas.map((ruta) {
                return DropdownMenuItem(value: ruta, child: Text(ruta));
              }).toList(),

              onChanged: (value) {
                setState(() {
                  rutaSeleccionada = value;
                });
              },
            ),

            DropdownButtonFormField<String>(
              initialValue: embarcacionSeleccionada,

              decoration: const InputDecoration(labelText: 'Embarcación'),

              items: embarcaciones.map((embarcacion) {
                return DropdownMenuItem(
                  value: embarcacion,
                  child: Text(embarcacion),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  embarcacionSeleccionada = value;
                });
              },
            ),

            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return capitanes;
                }

                return capitanes.where(
                  (capitan) => capitan.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },

              onSelected: (String selection) {
                capitanController.text = selection;
              },

              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                    controller.text = capitanController.text;

                    return TextField(
                      controller: controller,
                      focusNode: focusNode,

                      decoration: const InputDecoration(labelText: 'Capitán'),

                      onChanged: (value) {
                        capitanController.text = value;
                      },
                    );
                  },
            ),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return horarios;
                }

                return horarios.where(
                  (hora) => hora.contains(textEditingValue.text),
                );
              },

              onSelected: (String selection) {
                horaController.text = selection;
              },

              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                    controller.text = horaController.text;

                    return TextField(
                      controller: controller,
                      focusNode: focusNode,

                      decoration: const InputDecoration(labelText: 'Hora'),

                      onChanged: (value) {
                        horaController.text = value;
                      },
                    );
                  },
            ),
            TextField(
              controller: observacionesController,
              decoration: const InputDecoration(labelText: 'Observaciones'),
            ),

            const SizedBox(height: 30),

            const Text(
              'Agregar pasajero',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
            ),

            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),

            TextField(
              controller: dniController,

              decoration: const InputDecoration(labelText: 'DNI'),

              onChanged: (value) {
                if (value.length >= 7) {
                  buscarPasajeroPorDni(value);
                }
              },
            ),

            TextField(
              controller: fechaNacimientoController,
              decoration: const InputDecoration(
                labelText: 'Fecha de nacimiento',
              ),
            ),

            TextField(
              controller: nacionalidadController,
              decoration: const InputDecoration(labelText: 'Nacionalidad'),
            ),
            TextField(
              controller: observacionesPasajeroController,

              decoration: const InputDecoration(
                labelText: 'Observaciones pasajero',
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: agregarPasajero,
              child: const Text('Agregar pasajero'),
            ),

            const SizedBox(height: 20),

            const Text(
              'Pasajeros cargados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...pasajeros.asMap().entries.map((entry) {
              int index = entry.key;
              Pasajero pasajero = entry.value;

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),

                  title: Text('${pasajero.apellido} ${pasajero.nombre}'),

                  subtitle: Text('DNI: ${pasajero.dni}'),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),

                    onPressed: () {
                      eliminarPasajero(index);
                    },
                  ),
                ),
              );
            }),

            const SizedBox(height: 10),

            Text(
              'Total pasajeros: ${pasajeros.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: guardarViaje,
              child: const Text('Guardar viaje'),
            ),
          ],
        ),
      ),
    );
  }
}
