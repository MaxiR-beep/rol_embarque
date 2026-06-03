import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

import 'models/pasajero.dart';
import 'models/viaje.dart';

import 'screens/viajes_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  Hive.registerAdapter(PasajeroAdapter());

  Hive.registerAdapter(ViajeAdapter());

  await Hive.openBox<Viaje>('viajes');
  await Hive.openBox<Pasajero>('pasajeros');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Viaje> viajes = [];
  @override
  void initState() {
    super.initState();

    cargarViajes();
  }

  void cargarViajes() {
    print('Pantalla cargada');

    final box = Hive.box<Viaje>('viajes');

    final datos = box.values.toList().reversed.toList();

    print('Viajes guardados: ${datos.length}');

    setState(() {
      viajes = datos;
    });
  }

  void agregarViaje(Viaje viaje) async {
    final box = Hive.box<Viaje>('viajes');

    await box.put(viaje.id, viaje);

    cargarViajes();
  }

  void eliminarViaje(String id) async {
    final box = Hive.box<Viaje>('viajes');

    await box.delete(id);

    cargarViajes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Rol de Embarque',

      theme: ThemeData(primarySwatch: Colors.blue),

      home: ViajesScreen(
        viajes: viajes,
        onAgregarViaje: agregarViaje,
        onEliminarViaje: eliminarViaje,
      ),
    );
  }
}
