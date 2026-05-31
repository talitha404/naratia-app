import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = 'Elina';
  String get username => _username;

  String _email = 'elina@gmail.com';
  String get email => _email;

  // LOAD USER DARI API (PAKAI TOKEN)
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // ❗ kalau token tidak ada → stop
    if (token == null) {
      print('Token tidak ditemukan, user belum login');
      return;
    }

    final data = await ApiService.getUser(token);

    if (data != null) {
      _username = data['username'] ?? 'No Name';
      _email = data['email'] ?? 'No Email';

      notifyListeners();
    } else {
      print('Gagal ambil user (unauthorized / token salah)');
    }
  }

  // SIMPAN USERNAME (LOCAL)
  Future<void> saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', name);

    _username = name;
    notifyListeners();
  }

  // SIMPAN EMAIL (LOCAL)
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);

    _email = email;
    notifyListeners();
  }
}