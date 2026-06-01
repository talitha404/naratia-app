import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> register(
  String username,
  String email,
  String password,
) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    return response.statusCode == 200 ||
        response.statusCode == 201;
  } catch (e) {
    print('REGISTER ERROR: $e');
    return false;
  }
}

  static Future<Map<String, dynamic>?> getUser(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}