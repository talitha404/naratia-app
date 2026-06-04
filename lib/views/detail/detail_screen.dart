import 'package:flutter/material.dart';
import '../baca/baca_screen.dart';

class DetailScreen extends StatelessWidget {
  // Variabel penampung data dari halaman sebelumnya
  final int storyId;
  final String title;
  final String imagePath;
  final String authorName;
  final String token;
  final bool isFromLibrary; 

  const DetailScreen({
    super.key, 
    required this.title, 
    required this.imagePath,
    this.storyId = 1,              
    this.authorName = 'Layla.one',   
    this.token = '',                
    this.isFromLibrary = false,     
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cover Buku
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath.startsWith('http')
                  ? Image.network(
                      imagePath,
                      height: 200,
                      width: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: 140,
                          color: Colors.grey[900],
                          child: const Icon(Icons.broken_image, color: Colors.white54),
                        );
                      },
                    )
                  : Image.asset(
                      imagePath,
                      height: 200,
                      width: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: 140,
                          color: Colors.grey[900],
                          child: const Icon(Icons.broken_image, color: Colors.white54),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 24),
            
            // Judul Dinamis
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // ✨ PENULIS TETAP TAMPIL DI SINI (Statik & Gak Bisa Diklik)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.edit, color: Colors.white54, size: 14),
                const SizedBox(width: 4),
                Text(authorName, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                  child: const Text('15+', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Genre Tags Dummy
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTag('Romance'), _buildTag('Fantasi'), _buildTag('Petualangan'),
              ],
            ),
            const SizedBox(height: 24),

            // Sinopsis
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 32),

            // Tombol Mulai Baca
            if (!isFromLibrary) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BacaScreen(
                          storyId: storyId,
                          storyTitle: title,
                          coverUrl: imagePath, // ✂️ Parameter authorName udah sukses dibuang dari sini!
                          token: token,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text(
                    'MULAI BACA',
                    style: TextStyle(color: Color(0xFF610094), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}