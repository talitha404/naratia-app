import 'package:flutter/material.dart';

enum SearchState { initial, history, results }

class SearchViewModel extends ChangeNotifier {
  SearchState _currentState = SearchState.initial;
  SearchState get currentState => _currentState;

  String _resultTitle = "";
  String get resultTitle => _resultTitle;

  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> get searchResults => _searchResults;

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

  // --- TAMBAHAN: Fungsi pintar untuk memunculkan 1 novel sesuai kata kunci ---
  void _loadDummyResults(String keyword) {
    String lowerKeyword = keyword.toLowerCase();
    
    // Kalau yang diketik berhubungan dengan misteri/wild
    if (lowerKeyword.contains('wild') || lowerKeyword.contains('misteri')) {
      _searchResults = [
        {
          "title": "WHAT SHOULD BE WILD",
          "description": "Alam liar memanggil. Menemukan rahasia kelam dari hutan terlarang...",
          "author": "Kezia Ros", 
          "genre_1": "MISTERI",
          "genre_2": ""
        }
      ];
    } else {
      _searchResults = [
        {
          "title": "A THEORY DREAMING",
          "description": "Mimpi yang menjadi kenyataan membawa Nisa melintasi batas realita dan imajinasi...",
          "author": "Luna Rara", 
          "genre_1": "ROMANTIS",
          "genre_2": "FANTASI"
        }
      ];
    }
  }

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
      _resultTitle = 'HASIL UNTUK "${value.toUpperCase()}"';
      _loadDummyResults(value); // Panggil novel sesuai ketikan
      notifyListeners();
    }
  }

  // Logika saat user klik genre atau history
  void selectKeyword(String keyword, {bool isGenre = false}) {
    _currentState = SearchState.results;
    _resultTitle = isGenre ? 'BUKU KATEGORI: ${keyword.toUpperCase()}' : 'HASIL UNTUK "${keyword.toUpperCase()}"';
    _loadDummyResults(keyword); // Panggil novel sesuai ketikan
    notifyListeners();
  }

  // Fungsi baru untuk mereset pencarian
  void resetSearch() {
    _currentState = SearchState.initial;
    _resultTitle = "";
    _searchResults = []; 
    notifyListeners();
  }
}