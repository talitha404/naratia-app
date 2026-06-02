import 'package:flutter/material.dart';

enum SearchState { initial, history, results }

class SearchViewModel extends ChangeNotifier {
  SearchState _currentState = SearchState.initial;
  SearchState get currentState => _currentState;

  String _resultTitle = "";
  String get resultTitle => _resultTitle;

  // Data Dummy yang dipindah dari UI
  final List<Map<String, String>> genres = [
    {'name': 'Romantis', 'img': 'https://picsum.photos/seed/romantis/300/300'},
    {'name': 'Fantasi', 'img': 'https://picsum.photos/seed/fantasi/300/300'},
    {'name': 'Kehidupan', 'img': 'https://picsum.photos/seed/kehidupan/300/300'},
    {'name': 'Horor', 'img': 'https://picsum.photos/seed/horor/300/300'},
    {'name': 'FanFiction', 'img': 'https://picsum.photos/seed/fanfic/300/300'},
    {'name': 'Drama', 'img': 'https://picsum.photos/seed/drama/300/300'},
    {'name': 'Detektif', 'img': 'https://picsum.photos/seed/detektif/300/300'},
    {'name': 'Petualangan', 'img': 'https://picsum.photos/seed/petualangan/300/300'},
    {'name': 'Thriller', 'img': 'https://picsum.photos/seed/thriller/300/300'},
    {'name': 'Fiksi Remaja', 'img': 'https://picsum.photos/seed/remaja/300/300'},
  ];

  final List<String> history = [
    'kisah cinta masa sekolah',
    'A Theory Dreaming',
    'misteri lab komputer'
  ];

  // Logika saat kotak pencarian di-klik atau kehilangan fokus
  void onSearchFocusChanged(bool hasFocus, String text) {
    if (hasFocus && text.isEmpty) {
      _currentState = SearchState.history;
      notifyListeners();
    } else if (!hasFocus && text.isEmpty) {
      if (_currentState == SearchState.results) return;
      _currentState = SearchState.initial;
      notifyListeners();
    }
  }

  // Logika saat user menekan enter
  void submitSearch(String value) {
    if (value.trim().isNotEmpty) {
      _currentState = SearchState.results;
      _resultTitle = 'Hasil untuk "$value"';
      notifyListeners();
    }
  }

  // Logika saat user klik genre atau history
  void selectKeyword(String keyword, {bool isGenre = false}) {
    _currentState = SearchState.results;
    _resultTitle = isGenre ? 'Buku Kategori: $keyword' : 'Hasil untuk "$keyword"';
    notifyListeners();
  }
  // Fungsi baru untuk mereset pencarian
  void resetSearch() {
    _currentState = SearchState.initial;
    _resultTitle = "";
    notifyListeners();
  }
}