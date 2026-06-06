import 'dart:convert';
import 'package:flutter/foundation.dart';
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

  Future<List<dynamic>> getGenres(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/genres'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  return jsonDecode(response.body);
}

  Future<Map<String, dynamic>> createStory({
    required String token,
    required String title,
    String? description,
    int? genreId,
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
          if (description != null && description.isNotEmpty)
            'description': description,
          if (genreId != null) 'genre_id': genreId,
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Failed: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      print('CREATE STORY ERROR: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createChapter({
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

      print("CHAPTER STATUS: ${response.statusCode}");
      print("CHAPTER BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      throw Exception("Create chapter failed: ${response.body}");
    } catch (e) {
      print('CREATE CHAPTER ERROR: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getChapter({
    required String token,
    required int chapterId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chapters/$chapterId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      debugPrint(
        'Get Chapter gagal: ${response.statusCode}',
      );
      return null;
    } catch (e) {
      debugPrint('Get Chapter error: $e');
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

  Future<void> updateStory({
    required String token,
    required int storyId,
    required String status,
  }) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/stories/$storyId/status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal update story: ${response.body}");
    }
  }

  // 📖 Beranda
  Future<List<dynamic>?> fetchStories(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/stories'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('FETCH STORIES ERROR: $e');
      return null;
    }
  }

  // 📑 Daftar Bab
  Future<List<dynamic>?> fetchChapters(
    int storyId,
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/stories/$storyId/chapters'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('FETCH CHAPTERS ERROR: $e');
      return null;
    }
  }

  // 💬 Komentar
  Future<List<dynamic>?> fetchComments(
    int storyId,
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/stories/$storyId/comments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('FETCH COMMENTS ERROR: $e');
      return null;
    }
  }

  // ✍️ Tambah Komentar
  Future<dynamic> storeComment({
    required String token,
    required int storyId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/comments'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'story_id': storyId,
          'content': content,
        }),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('STORE COMMENT ERROR: $e');
      return null;
    }
  }

  // ❤️ Like
  Future<Map<String, dynamic>?> toggleLike({
    required String token,
    required int storyId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/likes/toggle'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'story_id': storyId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print('TOGGLE LIKE ERROR: $e');
      return null;
    }
  }

  // 📚 Bookmark
  Future<bool> addToLibrary({
    required String token,
    required int storyId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookmarks'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'story_id': storyId,
        }),
      );

      print('ADD TO LIBRARY STATUS: ${response.statusCode}');

      return response.statusCode == 200 ||
          response.statusCode == 201;
    } catch (e) {
      print('ADD TO LIBRARY ERROR: $e');
      return false;
    }
  }
}