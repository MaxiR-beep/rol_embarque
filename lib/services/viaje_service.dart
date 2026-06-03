import '../models/viaje.dart';
import 'supabase_service.dart';

class ViajeService {
  static Future<List<Viaje>> obtenerViajes() async {
    final data = await SupabaseService.client
        .from('viajes')
        .select('*, pasajeros(*)')
        .order('created_at', ascending: false);
    return data.map((json) => Viaje.fromJson(json)).toList();
  }

  static Future<Viaje> guardarViaje(Viaje viaje) async {
    final viajeJson = viaje.toJson();
    viajeJson.remove('pasajeros');
    final response = await SupabaseService.client
        .from('viajes')
        .insert(viajeJson)
        .select()
        .single();

    for (final p in viaje.pasajeros) {
      await SupabaseService.client.from('pasajeros').insert({
        'viaje_id': response['id'],
        'apellido': p.apellido,
        'nombre': p.nombre,
        'dni': p.dni,
        'fecha_nacimiento': p.fechaNacimiento,
        'nacionalidad': p.nacionalidad,
        'observaciones': p.observaciones,
      });
    }

    return obtenerViajes().then((v) => v.firstWhere((v) => v.id == response['id']));
  }

  static Future<void> eliminarViaje(String id) async {
    await SupabaseService.client.from('viajes').delete().eq('id', id);
  }
}