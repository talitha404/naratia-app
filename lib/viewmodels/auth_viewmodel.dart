import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  /// LOGIN
Future<bool> login(
  String email,
  String password,
) async {
  _setLoading(true);

  try {
    final result = await ApiService.login(
      email,
      password,
    );

    if (result == null) {
      return false;
    }

    final token = result['token'];
    final user = result['user'];

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString('token', token);

    await prefs.setString(
      'username',
      user['username'] ?? '',
    );

    await prefs.setString(
      'email',
      user['email'] ?? '',
    );

    await prefs.setString(
      'name',
      user['username'] ?? '',
    );

    _token = token;

    notifyListeners();

    return true;
  } catch (_) {
    return false;
  } finally {
    _setLoading(false);
  }
}

  /// LOAD TOKEN (dipanggil saat app start)
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  /// SAVE TOKEN (PRIVATE)
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// CHECK LOGIN STATUS
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  /// LOGOUT
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.clear();

  _token = null;

  notifyListeners();
}

  /// HELPER LOADING
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}