import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = 'cathleyaa.21';
  String get username => _username;

  String _email = 'elina@gmail.com';
  String get email => _email;

  String _name = 'cathleeyaa';
  String get name => _name;

  String _bio = 'Have nice day girls';
  String get bio => _bio;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Ambil data lokal yang pernah diedit
    _username = prefs.getString('username') ?? _username;
    _email = prefs.getString('email') ?? _email;
    _name = prefs.getString('name') ?? _name;
    _bio = prefs.getString('bio') ?? _bio;

    notifyListeners();
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);

    _username = username;
    notifyListeners();
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);

    _email = email;
    notifyListeners();
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);

    _name = name;
    notifyListeners();
  }

  Future<void> saveBio(String bio) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('bio', bio);

    _bio = bio;
    notifyListeners();
  }
}