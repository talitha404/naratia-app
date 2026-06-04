import 'package:flutter/material.dart';

class BacaScreen extends StatelessWidget {
  final String title;
  final bool isFromLibrary; // Penentu dari mana layar ini dibuka

  const BacaScreen({
    super.key, 
    required this.title,
    this.isFromLibrary = false, // Default-nya false (munculin popup)
  });

  // Fungsi untuk memunculkan popup dialog
  void _tampilkanDialogSimpan(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("Simpan ke Perpustakaan?", style: TextStyle(color: Colors.white)),
          content: const Text(
            "Simpan cerita ini ke daftar koleksi perpustakaan Anda untuk dibaca nanti.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            // Tombol Keluar
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Keluar layar baca
              },
              child: const Text("Keluar Saja", style: TextStyle(color: Colors.grey)),
            ),
            // Tombol Simpan
            ElevatedButton(
              onPressed: () {
                // TODO: Nanti fungsi panggil API ditaruh di sini
                
                Navigator.pop(context); // Tutup dialog
                
                // Munculin notifikasi kecil sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Berhasil disimpan ke Perpustakaan! 📚"),
                    backgroundColor: Color(0xFF610094),
                  ),
                );
                
                Navigator.pop(context); // Keluar layar baca
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF610094)),
              child: const Text("Simpan", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // PopScope menahan tombol back fisik Android
    return PopScope(
      canPop: isFromLibrary, 
      onPopInvoked: (didPop) {
        if (didPop) return;
        _tampilkanDialogSimpan(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              // Cek kalau dari library langsung keluar, kalau nggak tampilkan dialog
              if (isFromLibrary) {
                Navigator.pop(context);
              } else {
                _tampilkanDialogSimpan(context);
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Judul Buku
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            
            // Teks Cerita (Lorem Ipsum)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n"
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\n"
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.8),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            // Bottom Bar (Like, Komen, Share)
            Container(
              height: 60,
              decoration: const BoxDecoration(color: Color(0xFF610094)), // Ungu Pekat
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}