import 'package:flutter/material.dart';
import 'detalle_viaje_screen.dart';
import '../models/viaje.dart';
import 'crear_viaje_screen.dart';

class ViajesScreen extends StatelessWidget {
  final List<Viaje> viajes;
  final Function(Viaje) onAgregarViaje;
  final Function(String) onEliminarViaje;
  const ViajesScreen({
    super.key,
    required this.viajes,
    required this.onAgregarViaje,
    required this.onEliminarViaje,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viajes Registrados')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) => CrearViajeScreen(onGuardar: onAgregarViaje),
            ),
          );
        },
      ),

      body: ListView.builder(
        itemCount: viajes.length,

        itemBuilder: (context, index) {
          final viaje = viajes[index];

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),

                onPressed: () {
                  onEliminarViaje(viaje.id);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => DetalleViajeScreen(viaje: viaje),
                  ),
                );
              },
              leading: const Icon(Icons.directions_boat),

              title: Text('${viaje.origen} → ${viaje.destino}'),

              subtitle: Text(
                'Capitán: ${viaje.capitan}\n'
                'Fecha: ${viaje.fecha} - Hora: ${viaje.hora}\n'
                'Pasajeros: ${viaje.pasajeros.length}',
              ),

              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
