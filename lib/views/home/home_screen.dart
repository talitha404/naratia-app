import 'package:flutter/material.dart';

// 🔥 Import semua halaman
import 'home_content.dart';
import '../library/library_screen.dart';
import '../search/search_screen.dart';
import '../write/write_hub_screen.dart';
import '../profile/profile_screen.dart';

import 'package:provider/provider.dart';
import '../../viewmodels/search_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _titles = const [
    'Naratia',
    'Perpustakaan',
    'Cari',
    'Tulis',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      // ================= APPBAR =================
      appBar: (_currentIndex == 0 || _currentIndex == 2)
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF121212),
              elevation: 0,
              centerTitle: true,
              title: Text(
                _titles[_currentIndex],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

      // ================= BODY =================
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeContent(
            onNavigate: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          const LibraryScreen(),
          const SearchScreen(),
          const WriteHubScreen(),
          const ProfileScreen(),
        ],
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,

          onTap: (index) {
            if (_currentIndex == 2 && index == 2) {
              context.read<SearchViewModel>().resetSearch();
            }

            setState(() {
              _currentIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purpleAccent,
          unselectedItemColor: Colors.white60,
          showSelectedLabels: false,
          showUnselectedLabels: false,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Cari',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note),
              label: 'Tulis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}