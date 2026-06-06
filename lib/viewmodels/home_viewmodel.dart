import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  List<dynamic> _stories = [];
  bool _isLoading = false;

  List<dynamic> get stories => _stories;
  bool get isLoading => _isLoading;

  Future<void> fetchStories() async {
    _isLoading = true;
    notifyListeners();
    print("--- SEDANG MENCOBA MENGHUBUNGI LARAVEL ---");

    try {
      // 🚀 KITA TEMBAK LANGSUNG KE LARAVEL TANPA PERANTARA
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/stories'));
      print("--- STATUS CODE: ${response.statusCode} ---");
      print("--- DATA YANG DITERIMA: ${response.body} ---");

      if (response.statusCode == 200) {
        _stories = jsonDecode(response.body);
        debugPrint("SUKSES DATAPAT DATA: $_stories");
      } else {
        debugPrint("GAGAL: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("ERROR FATAL: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}