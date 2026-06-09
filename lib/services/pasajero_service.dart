import 'supabase_service.dart';

class PasajeroService {
  static Future<List<Map<String, dynamic>>> buscarPorDni(String dni) async {
    final data = await SupabaseService.client
        .from('pasajeros')
        .select()
        .eq('dni', dni)
        .order('created_at', ascending: false)
        .limit(1);
    return data;
  }
}