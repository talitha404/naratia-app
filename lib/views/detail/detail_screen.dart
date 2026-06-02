import 'package:flutter/material.dart';
import '../baca/baca_screen.dart'; 

class DetailScreen extends StatelessWidget {
  final String title;
  final String image;

  const DetailScreen({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      
      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ================= BODY (Konten Detail) =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cover Buku
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                height: 220,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Judul
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Penulis & Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.edit, color: Colors.white70, size: 14),
                const SizedBox(width: 6),
                const Text('Layla_one', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('R', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
                const SizedBox(width: 6),
                const Text('15+', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 20),

            // Tags / Genre
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTag('Romance'),
                const SizedBox(width: 10),
                _buildTag('Fantasi'),
                const SizedBox(width: 10),
                _buildTag('Petualangan'),
              ],
            ),
            const SizedBox(height: 30),

            // Sub-judul & Sinopsis
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),

      // ================= BOTTOM BAR (Hanya Tombol Mulai Baca) =================
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 10),
          color: const Color(0xFF121212),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Navigasi ke BacaScreen saat dipencet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BacaScreen(
                    title: title,
                    isAlreadyInLibrary: false, 
                  ),
                ),
              );
            },
            child: const Text(
              'MULAI BACA',
              style: TextStyle(
                color: Color(0xFF7512B6), // Warna ungu Naratia
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ); 
  } 

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}