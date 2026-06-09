import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/viaje.dart';
import '../providers/viaje_provider.dart';
import '../providers/auth_provider.dart';
import 'crear_viaje_screen.dart';
import 'detalle_viaje_screen.dart';

class ViajesScreen extends ConsumerWidget {
  const ViajesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viajesAsync = ref.watch(viajeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Viajes Registrados'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authNotifierProvider).signOut();
            },
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CrearViajeScreen(
                onGuardar: (viaje) {
                  ref.read(viajeProvider.notifier).agregarViaje(viaje);
                },
              ),
            ),
          );
        },
      ),
      body: viajesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (viajes) => ListView.builder(
          itemCount: viajes.length,
          itemBuilder: (context, index) {
            final viaje = viajes[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    ref.read(viajeProvider.notifier).eliminarViaje(viaje.id);
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
      ),
    );
  }
}