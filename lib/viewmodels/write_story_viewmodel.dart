import 'package:flutter/material.dart';
import '../services/api_service.dart';

class WriteStoryViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;

  int? currentStoryId;

  String? selectedImagePath;

  void setImagePath(String path) {
    selectedImagePath = path;
    notifyListeners();
  }

  // ===============================
  // CREATE STORY
  // ===============================
  Future<bool> createStory({
    required String token,
    required String title,
    required String description,
    required int? genreId,
  }) async {
    isLoading = true;
    notifyListeners();

    final response = await _api.createStory(
      token: token,
      title: title,
      description: description,
      genreId: genreId,
    );

    isLoading = false;
    notifyListeners();

    if (response != null && response['data'] != null) {
      currentStoryId = response['data']['id'];
      return true;
    }

    return false;
  }

  // ===============================
  // CREATE / AUTO SAVE CHAPTER
  // ===============================
  Future<bool> saveChapter({
    required String token,
    required int storyId,
    required int chapterNumber,
    required String title,
    required String content,
  }) async {
    final response = await _api.createChapter(
      token: token,
      storyId: storyId,
      chapterNumber: chapterNumber,
      title: title,
      content: content,
    );

    return response != null;
  }

  // ===============================
  // UPDATE CHAPTER
  // ===============================
  Future<bool> updateChapter({
    required String token,
    required int chapterId,
    required String title,
    required String content,
  }) async {
    final response = await _api.updateChapter(
      token: token,
      chapterId: chapterId,
      title: title,
      content: content,
    );

    return response != null;
  }
}