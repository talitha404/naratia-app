import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {

  String _username = 'Elina';

  String get username => _username;

  String _email = 'elina@gmail.com';

  String get email => _email;

Future<void> loadUsername() async {
  final prefs = await SharedPreferences.getInstance();

  _username =
      prefs.getString('username') ?? 'Elina';

  _email =
      prefs.getString('email') ??
      'elina@gmail.com';

  notifyListeners();
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