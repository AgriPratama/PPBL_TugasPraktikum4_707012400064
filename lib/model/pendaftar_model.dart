import 'package:flutter/foundation.dart';

class Pendaftar {
  final String nama;
  final String email;
  final String sesi;
  bool selesai;

  Pendaftar({
    required this.nama,
    required this.email,
    required this.sesi,
    this.selesai = false,
  });
}

class PendaftarModel extends ChangeNotifier {
  final List<Pendaftar> _daftar = [];

  List<Pendaftar> get daftar => List.unmodifiable(_daftar);

  void tambah(Pendaftar pendaftar) {
    _daftar.add(pendaftar);
    notifyListeners();
  }

  void tandaiSelesai(Pendaftar pendaftar) {
    pendaftar.selesai = true;
    notifyListeners();
  }

  int jumlahSesi(String sesi) {
    return _daftar.where((p) => p.sesi == sesi).length;
  }

  int get total => _daftar.length;
}
