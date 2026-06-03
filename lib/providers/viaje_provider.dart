import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/viaje.dart';
import '../services/viaje_service.dart';

final viajeProvider = StateNotifierProvider<ViajeListNotifier, AsyncValue<List<Viaje>>>((ref) {
  return ViajeListNotifier();
});

class ViajeListNotifier extends StateNotifier<AsyncValue<List<Viaje>>> {
  ViajeListNotifier() : super(const AsyncValue.loading()) {
    cargarViajes();
  }

  Future<void> cargarViajes() async {
    try {
      final viajes = await ViajeService.obtenerViajes();
      state = AsyncValue.data(viajes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> agregarViaje(Viaje viaje) async {
    try {
      await ViajeService.guardarViaje(viaje);
      await cargarViajes();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> eliminarViaje(String id) async {
    try {
      await ViajeService.eliminarViaje(id);
      await cargarViajes();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}