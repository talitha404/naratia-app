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
    required String description,
    required int genreId,
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
      final id = response['data']['id'] as int;
      currentStoryId = id;
      return id;
    }

    //lempar error
    throw Exception("Gagal membuat story");
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

    if (response != null && response['data'] != null) {
      final chapter = Chapter.fromJson(response['data']);

      currentChapter = chapter;
      notifyListeners();

      return chapter;
    }

    throw Exception("Gagal membuat chapter");
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