import 'package:flutter/material.dart';

class PublishedListScreen extends StatefulWidget {
  const PublishedListScreen({super.key});

  @override
  State<PublishedListScreen> createState() => _PublishedListScreenState();
}

class _PublishedListScreenState extends State<PublishedListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313), // Latar belakang gelap Naratia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.business_center_outlined, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Cerita Terpublikasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Kolom Pencarian (Search Bar) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white, // Latar belakang putih kontras sesuai mockup
                hintText: 'Cari Daftar Cerita ...',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 2. Daftar Cerita Terpublikasi
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4.0, 12.0, 0.0, 12.0),
                    child: Text(
                      'Daftar Cerita',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // UI DUMMY Item 1: Kisah Cinta ANDROMEDA
                  _buildPublishedCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Kisah Cinta ANDROMEDA',
                    genre: 'Romantis',
                    readers: '543 Pembaca',
                    onEdit: () {},
                    onAddBab: () {},
                    onKarakter: () {},
                    onMoreTap: () {},
                  ),
                  
                  // UI DUMMY Item 2: Cinta Dalam Bayangan
                  _buildPublishedCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Cinta Dalam Bayangan',
                    genre: 'Romantis',
                    readers: '1.5K Pembaca',
                    onEdit: () {},
                    onAddBab: () {},
                    onKarakter: () {},
                    onMoreTap: () {},
                  ),
                  
                  // UI DUMMY Item 3: Senja di Ujung Ombak
                  _buildPublishedCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Senja di Ujung Ombak',
                    genre: 'Kehidupan',
                    readers: '1.9K Pembaca',
                    onEdit: () {},
                    onAddBab: () {},
                    onKarakter: () {},
                    onMoreTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Kartu Item Cerita Terpublikasi dengan 3 Tombol Aksi bawah
  Widget _buildPublishedCard({
    required String imageUrl,
    required String title,
    required String genre,
    required String readers,
    required VoidCallback onEdit,
    required VoidCallback onAddBab,
    required VoidCallback onKarakter,
    required VoidCallback onMoreTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B), // Warna background card gelap lembut
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Cover Mini
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 55,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        width: 55,
                        height: 75,
                        color: Colors.grey,
                        child: Icon(
                        Icons.image,
                        color: Colors.white.withOpacity(0.2),
                        ),
                    );
                },
                ),
              ),
              const SizedBox(width: 14),
              
              // Metadata Konten Atas
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
                        GestureDetector(
                          onTap: onMoreTap,
                          child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Informasi Baris Tengah: Genre & Jumlah Pembaca
                    Row(
                      children: [
                        // Tag Genre
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2A2A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.bookmark, color: Colors.grey, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                genre,
                                style: const TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Indikator Pembaca
                        Row(
                          children: [
                            const Icon(Icons.favorite, color: Colors.pinkAccent, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              readers,
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // 3 Tombol Aksi di bagian bawah kartu (Sesuai elemen warna-warni di Figma)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Tombol Edit (Kombinasi Biru Gelap)
              Expanded(
                child: _buildActionCardButton(
                  icon: Icons.edit,
                  label: 'Edit',
                  bgColor: const Color(0xFF1E293B),
                  textColor: const Color(0xFF38BDF8),
                  onTap: onEdit,
                ),
              ),
              const SizedBox(width: 8),
              
              // 2. Tombol Add Bab (Kombinasi Ungu Gelap)
              Expanded(
                child: _buildActionCardButton(
                  icon: Icons.add_circle_outline,
                  label: 'Add Bab',
                  bgColor: const Color(0xFF3B0764),
                  textColor: const Color(0xFFC084FC),
                  onTap: onAddBab,
                ),
              ),
              const SizedBox(width: 8),
              
              // 3. Tombol Karakter (Kombinasi Jingga/Kuning Gelap)
              Expanded(
                child: _buildActionCardButton(
                  icon: Icons.people_outline,
                  label: 'Karakter',
                  bgColor: const Color(0xFF451A03),
                  textColor: const Color(0xFFFDBA74),
                  onTap: onKarakter,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Helper Widget khusus untuk menyusun 3 tombol kecil di bawah card secara presisi
  Widget _buildActionCardButton({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 12),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}