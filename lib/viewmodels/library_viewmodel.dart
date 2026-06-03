import 'package:flutter/material.dart';
import '../models/story.dart';

class LibraryViewModel extends ChangeNotifier {
  final List<StoryModel> _stories = [
    StoryModel(
      title: 'A THEORY DREAMING',
      image: 'assets/images/book2.png',
    ),
    StoryModel(
      title: 'WHAT SHOULD BE WILD',
      image: 'assets/images/book1.png',
    ),
    StoryModel(
      title: 'REWRITING MEMORIES',
      image: 'assets/images/book3.png',
    ),
    StoryModel(
      title: 'AFTERLIFE',
      image: 'assets/images/book4.png',
    ),
  ];

  // Variabel penampung cerita yang dipilih
  StoryModel? _selectedStory;

  List<StoryModel> get stories => _stories;
  StoryModel? get selectedStory => _selectedStory;

  // Fungsi untuk mengubah cerita aktif saat kartu diklik
  void selectStory(StoryModel story) {
    _selectedStory = story;
    notifyListeners(); // Mengabari UI untuk memperbarui konten
  }
}