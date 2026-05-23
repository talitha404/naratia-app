// File ini untuk dashboard tulis

import 'package:flutter/material.dart';

class WriteHubScreen extends StatefulWidget {
  const WriteHubScreen({super.key});

  @override
  State<WriteHubScreen> createState() => _WriteHubScreenState();
}

class _WriteHubScreenState extends State<WriteHubScreen> {
  // Mengatur index aktif untuk bottom navigation bar (Menu Tulis berada di index 3)
  int _currentIndex = 3; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313),
      appBar: AppBar(
        title: const Text(
          'Tulis Karya',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF141313),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            
            // 1. Tombol Buat Cerita Baru
            _buildMenuButton(
              context: context,
              icon: Icons.note_add_outlined,
              title: 'Buat Cerita Baru',
              subtitle: 'Mulai Tulis Cerita Baru',
              onTap: () {
                // Navigasi ke halaman buat cerita
                // Navigator.pushNamed(context, '/create-story');
              },
            ),
            
            const SizedBox(height: 20),
            
            // 2. Tombol Draf Cerita
            _buildMenuButton(
              context: context,
              icon: Icons.insert_drive_file_outlined,
              title: 'Draf Cerita',
              subtitle: 'Kelola dan Lanjutkan Draf Anda',
              onTap: () {
                // Navigasi ke daftar draf cerita
                // Navigator.pushNamed(context, '/draft-list');
              },
            ),
            
            const SizedBox(height: 20),
            
            // 3. Tombol Cerita Terpublikasi
            _buildMenuButton(
              context: context,
              icon: Icons.cloud_done_outlined,
              title: 'Cerita Terpublikasi',
              subtitle: 'Lihat Karya yang Sudah Rilis',
              onTap: () {
                // Navigasi ke daftar cerita terpublikasi
                // Navigator.pushNamed(context, '/published-list');
              },
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF141313),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1A1919), // Sedikit lebih terang dari background agar kontras
          selectedItemColor: Colors.purpleAccent, // Warna aktif sesuai aksen bawah Figma
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            // Tambahkan logika navigasi antar screen berdasarkan index di sini jika diperlukan
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_outlined),
              activeIcon: Icon(Icons.edit_note),
              label: 'Write',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membuat tombol menu yang seragam
  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF222121), // Warna container abu-abu gelap
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}