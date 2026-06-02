import 'package:flutter/material.dart';
import '../models/story.dart';

class LibraryViewModel extends ChangeNotifier {
  final List<StoryModel> _stories = [
    StoryModel(
      title: 'A THEORY DREAMING',
      image: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500',
    ),
    StoryModel(
      title: 'WHAT SHOULD BE WILD',
      image: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500',
    ),
    StoryModel(
      title: 'REWRITING MEMORIES',
      image: 'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=500',
    ),
    StoryModel(
      title: 'AFTERLIFE',
      image: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500',
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