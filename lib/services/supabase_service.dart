import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://swwrtmdvdzxcyzlsehox.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN3d3J0bWR2ZHp4Y3l6bHNlaG94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA0ODg4NzIsImV4cCI6MjA5NjA2NDg3Mn0.ZkXgUoIwLT9lpxh7F9xgvNvv9cNzQJ6ZZWgEzkojPDw',
    );
  }
}