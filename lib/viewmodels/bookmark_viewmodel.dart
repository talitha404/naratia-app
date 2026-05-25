import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkViewModel extends ChangeNotifier {

  List<String> _savedStories = [];

  List<String> get savedStories => _savedStories;

  Future<void> loadBookmarks() async {

    final prefs =
        await SharedPreferences.getInstance();

    _savedStories =
        prefs.getStringList('bookmarks') ?? [];

    notifyListeners();
  }

  Future<void> addBookmark(String story) async {

    if (!_savedStories.contains(story)) {

      _savedStories.add(story);

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setStringList(
        'bookmarks',
        _savedStories,
      );

      notifyListeners();
    }
  }

  Future<void> removeBookmark(String story) async {

    _savedStories.remove(story);

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setStringList(
      'bookmarks',
      _savedStories,
    );

    notifyListeners();
  }
}