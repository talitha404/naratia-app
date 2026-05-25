// nulis isi cerita
import 'package:flutter/material.dart';
import 'preview_screen.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313), // Background utama Naratia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buat cerita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          // Tombol simpan/pratinjau di pojok kanan atas jika diperlukan
          TextButton(
            onPressed: () {
              // Logika simpan draf
            },
            child: const Text(
              'Simpan',
              style: TextStyle(color: Color(0xFFBC84EE), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // 1. Input Judul Bab
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Judul bab',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            
            // Garis pembatas tipis di bawah judul seperti di Figma
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.1),
            ),
            
            const SizedBox(height: 16),

            // 2. Area Utama Tempat Menulis Cerita
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null, // Membuatnya bisa di-scroll tanpa batas ke bawah
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6, // Mengatur jarak antar baris teks agar nyaman dibaca
                ),
                decoration: InputDecoration(
                  hintText: 'Mulai tulis...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.2),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. Bottom Toolbar Khusus Editor (Berwarna Ungu di Figma)
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom + 12, // Menyesuaikan area aman bottom bar HP
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF6A1B9A), // Warna ungu tua sesuai komponen bar editor di Figma
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.undo, color: Colors.white),
              onPressed: () {
                // Logika Undo
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo, color: Colors.white),
              onPressed: () {
                // Logika Redo
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_fields, color: Colors.white),
              onPressed: () {
                // Logika pengaturan ukuran font / format text
              },
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Colors.white),
              onPressed: () {
                // Logika penanda selesai / validasi bab
              },
            ),
            IconButton(
              icon: const Icon(Icons.visibility_outlined, color: Colors.white),
              onPressed: () {
                // Logika melihat preview cerita
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PreviewScreen()),
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}