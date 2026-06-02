import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _name = '';
  String _bio = '';

  String get username => _username;
  String get email => _email;
  String get name => _name;
  String get bio => _bio;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    _username =
        prefs.getString('username') ?? '';

    _email =
        prefs.getString('email') ?? '';

    _name =
        prefs.getString('name') ??
        _username;

    _bio =
        prefs.getString('bio') ?? '';

    notifyListeners();
  }

  Future<void> saveUsername(
    String username,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'username',
      username,
    );

    _username = username;
    notifyListeners();
  }

  Future<void> saveEmail(
    String email,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'email',
      email,
    );

    _email = email;
    notifyListeners();
  }

  Future<void> saveName(
    String name,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'name',
      name,
    );

    _name = name;
    notifyListeners();
  }

  Future<void> saveBio(
    String bio,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'bio',
      bio,
    );

    _bio = bio;
    notifyListeners();
  }
}