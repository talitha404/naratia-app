import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data statis sesuai tampilan di Figma
    const String storyTitle = 'Senja Biru';
    const String storyContent = 
        'Langit sore itu berwarna biru pucat, seolah menyimpan rahasia yang tak ingin diungkapkan. '
        'Di tepi pantai kecil yang jarang dikunjungi orang, Aruna duduk menatap cakrawala. '
        'Angin membawa aroma asin laut, sementara ombak berkejaran, pecah di karang, lalu kembali lagi. '
        'Senja biru itu bukan sekadar pemandangan, melainkan ruang sunyi tempat ia menyembunyikan segala resah.\n\n'
        'Aruna baru saja kembali dari kota, meninggalkan hiruk pikuk yang penuh ambisi. '
        'Ia merasa asing di tengah gedung-gedung tinggi, seakan dirinya hanyalah bayangan yang tak pernah benar-benar hadir. '
        'Di pantai ini, ia mencari jawaban—tentang siapa dirinya, tentang apa yang sebenarnya ia kejar.';

    return Scaffold(
      backgroundColor: const Color(0xFF141313), // Tema gelap Naratia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Logika membuka daftar isi atau pengaturan membaca
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Area Konten yang Bisa Di-scroll
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Judul Cerita / Bab
                  const Text(
                    storyTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 2. Bar Statistik (Views, Likes, Comments) sesuai ikon kecil di Figma
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatItem(Icons.visibility_outlined, '0'),
                      const SizedBox(width: 20),
                      _buildStatItem(Icons.favorite_border, '0'),
                      const SizedBox(width: 20),
                      _buildStatItem(Icons.chat_bubble_outline, '0'),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // 3. Isi Teks Cerita
                  const Text(
                    storyContent,
                    style: TextStyle(
                      color: Color(0xFFE0E0E0), // Putih lembut agar tidak terlalu kontras di layar gelap
                      fontSize: 16,
                      height: 1.8, // Spasi antar baris yang renggang agar nyaman dibaca
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          // 4. Bottom Toolbar Baca (Warna Ungu Gelap)
          Container(
            padding: EdgeInsets.only(
              left: 32,
              right: 32,
              top: 14,
              bottom: MediaQuery.of(context).padding.bottom + 14,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF32094D), // Ungu sangat gelap sesuai palet bar baca Figma kamu
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.text_format, color: Colors.white, size: 26),
                  onPressed: () {
                    // Logika penyesuaian ukuran font/background text
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, color: Colors.white, size: 26),
                  onPressed: () {
                    // Logika simpan bookmark/penanda halaman
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 26),
                  onPressed: () {
                    // Logika bagikan cerita
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk membuat bar stat kecil (mata, hati, komentar)
  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 16),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}