import 'package:flutter/material.dart';

import '../pages/formulir_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int indeksTerpilih = 0;

  final List<Widget> halaman = const [
    FormulirPage(),
    ChatPage(),
    PetaPage(),
    StatistikPage(),
  ];

  final List<String> judul = const [
    'Formulir',
    'Tanya Petugas',
    'Lokasi Kantor',
    'Statistik',
  ];

  void pilihTujuan(int indeks) {
    setState(() {
      indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layarLebar = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: layarLebar ? tataLetakLebar() : halaman[indeksTerpilih],
      bottomNavigationBar: layarLebar
          ? null
          : NavigationBar(
              selectedIndex: indeksTerpilih,
              onDestinationSelected: pilihTujuan,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: 'Formulir',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                NavigationDestination(
                  icon: Icon(Icons.map_outlined),
                  selectedIcon: Icon(Icons.map),
                  label: 'Peta',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Statistik',
                ),
              ],
            ),
    );
  }

  Widget tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: indeksTerpilih,
          onDestinationSelected: pilihTujuan,
          extended: true,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.assignment_outlined),
              selectedIcon: Icon(Icons.assignment),
              label: Text('Formulir'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.chat_outlined),
              selectedIcon: Icon(Icons.chat),
              label: Text('Chat'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: Text('Peta'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: Text('Statistik'),
            ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: halaman[indeksTerpilih]),
      ],
    );
  }
}
