import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/library_viewmodel.dart';

class BacaScreen extends StatelessWidget {
  const BacaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data cerita yang tadi dipilih lewat ViewModel
    final libraryVM = Provider.of<LibraryViewModel>(context, listen: false);
    final currentStory = libraryVM.selectedStory;

    if (currentStory == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(child: Text("Cerita tidak ditemukan", style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Warna gelap pekat halaman baca
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Aksi drawer menu bab di Figma kanan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Prolog',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Baris Info Statistik (Views, Likes, Comments)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('125K', style: TextStyle(color: Colors.grey, fontSize: 11)),
                SizedBox(width: 16),
                Icon(Icons.favorite_border, color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('18K', style: TextStyle(color: Colors.grey, fontSize: 11)),
                SizedBox(width: 16),
                Icon(Icons.maps_ugc_outlined, color: Colors.grey, size: 14),
                SizedBox(width: 4),
                Text('100', style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 24),

            // Konten Teks Cerita Utama
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n"
                  "Kamu sedang membaca cerita dengan judul: ${currentStory.title}. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.",
              textAlign: TextAlign.justify,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.7),
            ),
            const SizedBox(height: 40),

            // Tombol input nama interaktif ungu di Figma
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF6A0DAD), // Warna ungu ikonik Naratia
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Nama Anda...',
                  hintStyle: TextStyle(color: Colors.white60, fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // Bottom Bar Navigasi Ungu Sesuai Mockup Figma
      bottomNavigationBar: Container(
        height: 60,
        color: const Color(0xFF6A0DAD),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
            IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white), onPressed: () {}),
            IconButton(icon: const Icon(Icons.share_outlined, color: Colors.white), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}