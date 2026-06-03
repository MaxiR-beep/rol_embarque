import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/viaje.dart';
import 'crear_viaje_screen.dart';
import '../providers/viaje_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetalleViajeScreen extends ConsumerWidget {
  final Viaje viaje;
  const DetalleViajeScreen({super.key, required this.viaje});

  Future<void> generarPDF() async {
    try {
      final pdf = pw.Document();
      final logo = pw.MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
      );
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Image(logo, width: 70, height: 70),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text('ROL DE EMBARQUE',
                              style: pw.TextStyle(
                                  fontSize: 28,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 5),
                          pw.Text('Puerto Ituzaingó - Isla Apipé Grande',
                              style: const pw.TextStyle(fontSize: 14)),
                          pw.SizedBox(height: 15),
                          pw.Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('DATOS DEL VIAJE',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 16)),
                      pw.SizedBox(height: 10),
                      pw.Text('Ruta: ${viaje.origen} → ${viaje.destino}'),
                      pw.Text('Embarcación: ${viaje.embarcacion}'),
                      pw.Text('Capitán: ${viaje.capitan}'),
                      pw.Text('Fecha: ${viaje.fecha}'),
                      pw.Text('Hora: ${viaje.hora}'),
                      pw.Text(
                          'Cantidad de pasajeros: ${viaje.pasajeros.length}'),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Pasajeros', style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  headers: [
                    'DNI',
                    'Apellido y Nombre',
                    'Fecha Nac.',
                    'Nacionalidad',
                    'Observaciones'
                  ],
                  data: viaje.pasajeros
                      .map((p) => [
                            p.dni,
                            '${p.apellido} ${p.nombre}',
                            p.fechaNacimiento,
                            p.nacionalidad,
                            p.observaciones,
                          ])
                      .toList(),
                ),
                pw.SizedBox(height: 20),
                pw.Text('Observaciones:',
                    style: pw.TextStyle(fontSize: 16)),
                pw.Text(viaje.observaciones),
              ],
            );
          },
        ),
      );
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'rol_embarque_${viaje.fecha}.pdf',
      );
    } catch (e) {
      print('ERROR PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Viaje')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'pdf',
            child: const Icon(Icons.picture_as_pdf),
            onPressed: generarPDF,
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'editar',
            child: const Icon(Icons.edit),
            onPressed: () async {
              final editado = await Navigator.push<Viaje>(
                context,
                MaterialPageRoute(
                  builder: (_) => CrearViajeScreen(viaje: viaje, onGuardar: (_) {}),
                ),
              );
              if (editado != null) {
                ref.read(viajeProvider.notifier).agregarViaje(editado);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Ruta: ${viaje.origen} → ${viaje.destino}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Embarcación: ${viaje.embarcacion}'),
            Text('Capitán: ${viaje.capitan}'),
            Text('Fecha: ${viaje.fecha}'),
            Text('Hora: ${viaje.hora}'),
            const SizedBox(height: 20),
            Text('Pasajeros (${viaje.pasajeros.length})',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...viaje.pasajeros.map((pasajero) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('${pasajero.apellido} ${pasajero.nombre}'),
                  subtitle: Text('DNI: ${pasajero.dni}'),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text('Observaciones:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(viaje.observaciones),
          ],
        ),
      ),
    );
  }
}