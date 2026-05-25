import 'package:flutter/material.dart';

class DraftListScreen extends StatefulWidget {
  const DraftListScreen({super.key});

  @override
  State<DraftListScreen> createState() => _DraftListScreenState();
}

class _DraftListScreenState extends State<DraftListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313), // Tema Gelap Utama Naratia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Draf Cerita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Kolom Pencarian (Search Bar) sesuai di Figma
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF222121),
                hintText: 'Cari Draf...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.4)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25), // Gaya kapsul melengkung
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Konten Utama: Daftar Draf di dalam Container Berbingkai
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1B1B), // Background area list draf
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Draf Cerita',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Card Draf: Kisah Cinta ANDROMEDA
                    _buildDraftCard(
                      imageUrl: 'https://via.placeholder.com/150', // Bisa diganti aset cover lokal kamu
                      title: 'Kisah Cinta ANDROMEDA',
                      genre: 'Romantis',
                      lastEdited: 'Terakhir diedit 1 hari lalu',
                      onEditTap: () {
                        // Aksi ketika tombol Edit ditekan
                      },
                      onMoreTap: () {
                        // Aksi menu titik tiga (Klik Titik 3 di Figma)
                      },
                    ),
                    
                    // Kamu bisa duplikasi _buildDraftCard di sini untuk menambah draf lain
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Kartu Item Draf Cerita
  Widget _buildDraftCard({
    required String imageUrl,
    required String title,
    required String genre,
    required String lastEdited,
    required VoidCallback onEditTap,
    required VoidCallback onMoreTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF242323), // Kontainer abu gelap bagian dalam draf
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Thumbnail Cerita
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 70,
                  color: Colors.grey,
                  child: const Icon(Icons.image, color: Colors.white30, size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          
          // Informasi Detail Cerita
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Tombol Opsi Titik Tiga
                    GestureDetector(
                      onTap: onMoreTap,
                      child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // Tag Genre Mini
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    genre,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Informasi Kapan Terakhir Diedit & Tombol Edit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lastEdited,
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10),
                    ),
                    // Tombol Edit Mini Kapsul
                    SizedBox(
                      height: 26,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF323131),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onEditTap,
                        icon: const Icon(Icons.edit, size: 12, color: Color(0xFFBC84EE)),
                        label: const Text('Edit', style: TextStyle(fontSize: 11)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}