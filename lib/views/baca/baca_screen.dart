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
<<<<<<< Updated upstream
    // PopScope menahan tombol back fisik Android
    return PopScope(
      canPop: isFromLibrary, 
      onPopInvoked: (didPop) {
        if (didPop) return;
        _tampilkanDialogSimpan(context);
=======
    final currentChapter = _chapters.isNotEmpty ? _chapters[_currentChapterIndex] : null;

    return PopScope(
      canPop: widget.isFromLibrary,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showSaveToLibraryDialog();
>>>>>>> Stashed changes
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
<<<<<<< Updated upstream
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
=======
            onPressed: () => widget.isFromLibrary ? Navigator.pop(context) : _showSaveToLibraryDialog(),
          ),
          actions: [
            Builder(builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            )),
          ],
        ),
        endDrawer: Drawer(
          backgroundColor: const Color(0xFF1E1E1E),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 100, height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: NetworkImage(widget.coverUrl), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(widget.storyTitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Divider(color: Colors.white10, height: 30, thickness: 1),
                Expanded(
                  child: _chapters.isEmpty ? const Center(child: Text("Tidak ada bab", style: TextStyle(color: Colors.grey))) : ListView.builder(
                    itemCount: _chapters.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Bab ${_chapters[index]['chapter_number']} | ${_chapters[index]['title']}",
                          style: TextStyle(color: _currentChapterIndex == index ? const Color(0xFF610094) : Colors.white70, fontWeight: _currentChapterIndex == index ? FontWeight.bold : FontWeight.normal),
                        ),
                        onTap: () {
                          setState(() => _currentChapterIndex = index);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.purple))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("${currentChapter?['title'] ?? ''}".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Text(currentChapter?['content'] ?? 'Tidak ada teks isi bab.', style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.8), textAlign: TextAlign.justify),
                    ),
                  ),
                  Container(
                    height: 65,
                    decoration: const BoxDecoration(color: Color(0xFF610094)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                          onPressed: () async {
                            setState(() => _isLiked = !_isLiked);
                            await _apiService.toggleLike(token: widget.token, storyId: widget.storyId);
                          },
                        ),
                        IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: _showCommentBottomSheet),
                        IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () => Share.share("Baca ${widget.storyTitle} di Naratia!")),
                      ],
                    ),
                  ),
                ],
              ),
>>>>>>> Stashed changes
      ),
    );
  }
}