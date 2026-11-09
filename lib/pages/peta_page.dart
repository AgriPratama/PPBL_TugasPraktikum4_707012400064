import 'package:flutter/material.dart';

class PetaPage extends StatelessWidget {
  const PetaPage({super.key});

  final List<Map<String, String>> kantor = const [
    {
      'nama': 'Kantor Layanan 1',
      'alamat': 'Jl. Asia Afrika, Bandung',
      'jam': 'Senin - Jumat, 08.00 - 16.00',
    },
    {
      'nama': 'Kantor Layanan 2',
      'alamat': 'Jl. Diponegoro, Bandung',
      'jam': 'Senin - Jumat, 08.00 - 16.00',
    },
    {
      'nama': 'Kantor Layanan 3',
      'alamat': 'Jl. Soekarno Hatta, Bandung',
      'jam': 'Senin - Jumat, 08.00 - 16.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Kantor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 65, color: Colors.red.shade600),
                  const SizedBox(height: 8),
                  const Text(
                    'Peta Lokasi Kantor Layanan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Tampilan simulasi lokasi kantor',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daftar Kantor Layanan',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...kantor.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.location_on)),
                  title: Text(
                    item['nama']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(item['alamat']!),
                      const SizedBox(height: 4),
                      Text(item['jam']!),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
