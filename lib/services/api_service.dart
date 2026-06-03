import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api";

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
        body: jsonEncode({'email': email, 'password': password}),
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

    print('REGISTER STATUS: ${response.statusCode}');
    print('REGISTER BODY: ${response.body}');

    return response.statusCode == 200 ||
        response.statusCode == 201;
  } catch (e) {
    print('REGISTER ERROR: $e');
    return false;
  }
}

static Future<Map<String, dynamic>?> updateProfile(
  String token,
  String username,
  String name,
  String bio,
) async {
  final response = await http.put(
    Uri.parse('$baseUrl/profile'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
    body: {
      'username': username,
      'name': name,
      'bio': bio,
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  return null;
}

static Future<bool> sendFeedback(
  String token,
  String message,
) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'message': message,
      },
    );

    print('FEEDBACK STATUS: ${response.statusCode}');
    print('FEEDBACK BODY: ${response.body}');

    return response.statusCode == 200;
  } catch (e) {
    print('FEEDBACK ERROR: $e');
    return false;
  }
}

  static Future<Map<String, dynamic>?> getUser(String token) async {
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

  Future<dynamic> createStory({
    required String token,
    required String title,
    required String description,
    required int? genreId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/stories'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'genre_id': genreId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('CREATE STORY ERROR: $e');
      return null;
    }
  }

  Future<dynamic> createChapter({
    required String token,
    required int storyId,
    required int chapterNumber,
    required String title,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chapters'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'story_id': storyId,
          'chapter_number': chapterNumber,
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('CREATE CHAPTER ERROR: $e');
      return null;
    }
  }

  Future<dynamic> updateChapter({
    required String token,
    required int chapterId,
    required String title,
    required String content,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/chapters/$chapterId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('UPDATE CHAPTER ERROR: $e');
      return null;
    }
  }

}
