import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../services/api_service.dart';

class ReaderViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;

  List<Chapter> chapters = [];
  int currentIndex = 0;

  String? readerName; // untuk y/n system

  Chapter? get currentChapter {
    if (chapters.isEmpty) return null;
    return chapters[currentIndex];
  }

  // FETCH ALL CHAPTERS
  Future<void> fetchChapters({
    required String token,
    required int storyId,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _api.getChapter(
        token: token,
        chapterId: storyId,
      );

      if (response != null && response['data'] != null) {
        final List data = response['data'];

        chapters = data.map((e) => Chapter.fromJson(e)).toList();
        currentIndex = 0;
      }
    } catch (e) {
      debugPrint("Fetch chapters error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // 🔥 NEXT CHAPTER
  void nextChapter() {
    if (currentIndex < chapters.length - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  // 🔥 PREVIOUS CHAPTER
  void previousChapter() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  // 🔥 SET NAMA PEMBACA (Y/N SYSTEM)
  void setReaderName(String name) {
    readerName = name;
    notifyListeners();
  }

  // 🔥 GET CONTENT DENGAN REPLACE Y/N
  String get parsedContent {
    final content = currentChapter?.content ?? "";

    if (readerName == null || readerName!.isEmpty) {
      return content;
    }

    return content.replaceAll("y/n", readerName!);
  }

  // 🔥 GET TITLE
  String get parsedTitle {
    final title = currentChapter?.title ?? "";

    if (readerName == null || readerName!.isEmpty) {
      return title;
    }

    return title.replaceAll("y/n", readerName!);
  }
}