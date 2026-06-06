import 'package:flutter/material.dart';
import '../baca/baca_screen.dart';

class DetailScreen extends StatelessWidget {
  final int storyId;
  final String title;
  final String imagePath;
  final String authorName;
  final String synopsis;
  final String token;
  final bool isFromLibrary;

  const DetailScreen({
    super.key,
    required this.title,
    required this.imagePath,
    this.synopsis = '',
    this.storyId = 1,
    this.authorName = '',
    this.token = '',
    this.isFromLibrary = false,
  });

  @override
  Widget build(BuildContext context) {
    String judul = title.toUpperCase();
    String sinopsisTampil = (synopsis.isEmpty || synopsis == 'Tidak ada sinopsis tersedia.') 
        ? (judul == 'TAKDIR TERINDAH' ? 'Sebuah kisah tentang keajaiban dan takdir yang tak terduga.' : 'Kisah seru $title di Naratia.') 
        : synopsis;

    String penulisTampil = (authorName.isEmpty || authorName == 'Anonim')
        ? (judul == 'TAKDIR TERINDAH' ? 'Raisa Violet' : (judul == 'A THEORY DREAMING' ? 'Luna Fawn' : (judul == 'WHAT SHOULD BE WILD' ? 'Kaelen Roe' : (judul == 'REWRITING MEMORIES' ? 'Cora Sterling' : 'Dante Vane'))))
        : authorName;

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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imagePath.startsWith('http')
                  ? Image.network(imagePath, height: 200, width: 140, fit: BoxFit.cover)
                  : Image.asset(imagePath, height: 200, width: 140, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),
            Text(
              judul,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.edit, color: Colors.white54, size: 14),
                const SizedBox(width: 4),
                Text(
                  penulisTampil,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              sinopsisTampil,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BacaScreen(
                      storyId: storyId,
                      storyTitle: title,
                      coverUrl: imagePath,
                      token: token,
                    ),
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}