import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {

  String _username = 'Elina';

  String get username => _username;

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    _username = prefs.getString('username') ?? 'Elina';

    notifyListeners();
  }

  Future<void> saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', name);

    _username = name;

    notifyListeners();
  }
}