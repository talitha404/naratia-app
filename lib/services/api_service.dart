import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  /// LOGIN
  static Future<String?> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        return data['token'];
      } else {
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  /// GET USER (PROTECTED)
  static Future<Map<String, dynamic>?> getUser(String token) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/user'),
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      // Token invalid / expired
      if (response.statusCode == 401) {
        return null;
      }

      return null;
    } catch (e) {
      print('Get user error: $e');
      return null;
    }
  }
}