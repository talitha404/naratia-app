import 'package:flutter/material.dart';

// 🔥 Import semua halaman
import 'home_content.dart';
import '../library/library_screen.dart';
import '../search/search_screen.dart';
import '../write/write_hub_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // 🔥 List halaman utama
  final List<Widget> _screens = const [
    HomeContent(),
    LibraryScreen(),
    SearchScreen(),
    WriteHubScreen(),
    ProfileScreen(),
  ];

  // 🔥 Judul AppBar
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
      backgroundColor: const Color(0xFF121212), // ✅ tambahan

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                // TODO: Notifikasi
              },
            ),
        ],
      ),

      // ================= BODY =================
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF6A0DAD),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
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