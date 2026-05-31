import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class ProfileViewModel extends ChangeNotifier {

  String _username = 'Elina';

  String get username => _username;

  String _email = 'elina@gmail.com';

  String get email => _email;

  Future<void> loadUser() async {
    final data = await ApiService.getUser();

    if (data != null) {
      _username = data['username'];
      _email = data['email'];

      notifyListeners();
    } else {
      print('Gagal ambil user (unauthorized / token salah)');
    }
  }

  Future<void> saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', name);

    _username = name;

    notifyListeners();
  }

  Future<void> saveEmail(String email) async {

  final prefs =
      await SharedPreferences.getInstance();

  await prefs.setString('email', email);

  _email = email;

  notifyListeners();
}
}