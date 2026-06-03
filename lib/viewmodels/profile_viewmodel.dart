import 'package:flutter/material.dart';
import '../services/api_service.dart';
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

  Future<bool> updateProfile(
  String username,
  String name,
  String bio,
) async {
  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

  if (token == null) {
    return false;
  }

  final result =
      await ApiService.updateProfile(
    token,
    username,
    name,
    bio,
  );

  if (result != null) {
    final user = result['user'];

    _username =
        user['username'] ?? '';

    _name =
        user['name'] ?? '';

    _bio =
        user['bio'] ?? '';

    await prefs.setString(
      'username',
      _username,
    );

    await prefs.setString(
      'name',
      _name,
    );

    await prefs.setString(
      'bio',
      _bio,
    );

    notifyListeners();

    return true;
  }

  return false;
}

Future<bool> sendFeedback(
  String message,
) async {
  final prefs =
      await SharedPreferences.getInstance();

  final token =
      prefs.getString('token');

  if (token == null) {
    return false;
  }

  return await ApiService.sendFeedback(
    token,
    message,
  );
}
}