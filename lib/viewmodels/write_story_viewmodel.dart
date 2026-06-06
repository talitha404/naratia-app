import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../services/api_service.dart';

class WriteStoryViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;

  int? currentStoryId;

  Chapter? currentChapter;

  String? selectedImagePath;

  void setImagePath(String path) {
    selectedImagePath = path;
    notifyListeners();
  }

  // CREATE STORY (FIXED)
  Future<int> createStory({
    required String token,
    required String title,
    String? description,
    int? genreId,
    // required String status,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _api.createStory(
        token: token,
        title: title,
        description: description,
        genreId: genreId,
        // status: status,
      );

      print("RESPONSE: $response");

      int? id;

      if (response['data']?['id'] != null) {
        id = response['data']['id'];
      } else if (response['id'] != null) {
        id = response['id'];
      } else if (response['story']?['id'] != null) {
        id = response['story']['id'];
      }

      if (id == null) {
        throw Exception("ID tidak ditemukan: $response");
      }

      currentStoryId = id;
      return id;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  // CREATE CHAPTER (FIXED)
  Future<Chapter> createChapter({
    required String token,
    required int storyId,
    required String title,
    required String content,
    int chapterNumber = 1,
  }) async {
    final response = await _api.createChapter(
      token: token,
      storyId: storyId,
      chapterNumber: chapterNumber,
      title: title,
      content: content,
    );

    if (response['data'] != null) {
      final chapter = Chapter.fromJson(response['data']);

      currentChapter = chapter;
      notifyListeners();

      return chapter;
    }

    throw Exception("Gagal membuat chapter");
  }

  Future<void> updateStoryStatus({
    required String token,
    required int storyId,
    required String status,
  }) async {
    await _api.updateStory(
      token: token,
      storyId: storyId,
      status: status,
    );
  }

  Future<void> updateStory({
    required String token,
    required int storyId,
    required String status,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      await _api.updateStory(
        token: token,
        storyId: storyId,
        status: status,
      );
    } catch (e) {
      throw Exception("Gagal update story: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // AUTO SAVE (IMPROVED)
  Future<void> autoSave({
    required String token,
    required String content,
  }) async {
    if (currentChapter == null) {
      debugPrint("AutoSave dibatalkan: chapter belum ada");
      return;
    }

    // update local state dulu (optimistic update)
    currentChapter = currentChapter!.copyWith(content: content);
    try {
      await _api.updateChapter(
        token: token,
        chapterId: currentChapter!.id,
        title: currentChapter!.title,
        content: content,
      );
    } catch (e) {
      debugPrint("AutoSave error: $e");
    }
  }

  
  // UPDATE TITLE
  void updateChapterTitle(String title) {
    if (currentChapter == null) return;

    currentChapter = currentChapter!.copyWith(title: title);
    notifyListeners();
  }

}