import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pendaftar_model.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});

  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  bool setujuSyarat = false;
  String? sesiTerpilih;
  bool sedangMengirim = false;

  bool get formLengkap =>
      namaController.text.trim().isNotEmpty &&
      emailController.text.contains('@') &&
      setujuSyarat &&
      sesiTerpilih != null;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void resetForm() {
    setState(() {
      namaController.clear();
      emailController.clear();
      setujuSyarat = false;
      sesiTerpilih = null;
    });
  }

  Future<void> kirimFormulir() async {
    if (!formLengkap || sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PendaftarModel>().tambah(
      Pendaftar(
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        sesi: sesiTerpilih!,
      ),
    );

    setState(() {
      sedangMengirim = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pendaftaran berhasil dikirim!')),
    );

    resetForm();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PendaftarModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: resetForm,
        tooltip: 'Bersihkan formulir',
        child: const Icon(Icons.refresh),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppDetailRoute.detailKegiatan);
                },
                onLongPress: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Kegiatan: Seminar Teknologi Mobile'),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.event, color: Colors.deepPurple),
                  title: Text('Seminar Teknologi Mobile'),
                  subtitle: Text(
                    'Ketuk untuk detail, tahan untuk info singkat',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Data Peserta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: namaController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emailController,
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
                errorText:
                    emailController.text.isNotEmpty &&
                        !emailController.text.contains('@')
                    ? 'Email harus mengandung karakter @'
                    : null,
              ),
            ),

            const SizedBox(height: 12),

            CheckboxListTile(
              value: setujuSyarat,
              title: const Text(
                'Saya menyetujui syarat dan ketentuan kegiatan',
              ),
              onChanged: (nilai) {
                setState(() {
                  setujuSyarat = nilai ?? false;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text(
              'Pilih Sesi Kegiatan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            ...['Pagi', 'Siang', 'Sore'].map((sesi) {
              return RadioListTile<String>(
                title: Text('Sesi $sesi'),
                value: sesi,
                groupValue: sesiTerpilih,
                onChanged: (nilai) {
                  setState(() {
                    sesiTerpilih = nilai;
                  });
                },
              );
            }),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: (formLengkap && !sedangMengirim)
                  ? kirimFormulir
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: sedangMengirim
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kirim Pendaftaran'),
            ),

            const SizedBox(height: 24),

            const Text(
              'Riwayat Pendaftaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text('Total pendaftar: ${model.total}'),

            const SizedBox(height: 8),

            ...model.daftar.map((pendaftar) {
              return Card(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Detail Pendaftar'),
                        content: Text(
                          'Nama: ${pendaftar.nama}\n'
                          'Email: ${pendaftar.email}\n'
                          'Sesi: ${pendaftar.sesi}\n'
                          'Status: ${pendaftar.selesai ? "Selesai" : "Diproses"}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  onLongPress: () {
                    context.read<PendaftarModel>().tandaiSelesai(pendaftar);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengajuan ditandai selesai!'),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(pendaftar.nama),
                    subtitle: Text(
                      '${pendaftar.email} • Sesi ${pendaftar.sesi}',
                    ),
                    trailing: Icon(
                      pendaftar.selesai ? Icons.check_circle : Icons.pending,
                      color: pendaftar.selesai ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AppDetailRoute {
  static const String detailKegiatan = '/detail-kegiatan';
}
