import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; 
import '../../services/api_service.dart'; 
import 'package:provider/provider.dart';
import '../../viewmodels/profile_viewmodel.dart';

class BacaScreen extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  final String coverUrl;
  final String token;
  final bool isFromLibrary; 

  const BacaScreen({
    super.key,
    required this.storyId,
    required this.storyTitle,
    required this.coverUrl,
    required this.token,
    this.isFromLibrary = false, 
  });

  @override
  State<BacaScreen> createState() => _BacaScreenState();
}

class _BacaScreenState extends State<BacaScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _chapters = [];
  int _currentChapterIndex = 0; 
  bool _isLoading = true;
  bool _isLiked = false; 

  @override
  void initState() {
    super.initState();
    _loadChaptersData();
  }

  Future<void> _loadChaptersData() async {
    setState(() => _isLoading = true);
    final data = await _apiService.fetchChapters(widget.storyId, widget.token);
    
    if (data != null && data.isNotEmpty) {
      setState(() {
        _chapters = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _chapters = [{'chapter_number': 1, 'title': 'BAB 1', 'content': 'Teks cerita contoh...'}];
        _isLoading = false;
      });
    }
  }

  void _showSaveToLibraryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Simpan ke Library?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text("Apakah kamu ingin menyimpan cerita ini ke perpustakaan sebelum keluar?", style: TextStyle(color: Colors.white70, fontSize: 14)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); 
                Navigator.pop(context);      
              },
              child: const Text("Tidak", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF610094), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext); 
                bool success = await _apiService.addToLibrary(token: widget.token, storyId: widget.storyId);
                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cerita berhasil ditambahkan ke Library! 🎉"), backgroundColor: Colors.green));
                }
                if (mounted) Navigator.pop(context); 
              },
              child: const Text("Iya", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showCommentBottomSheet() {
    TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 16, right: 16),
          child: SizedBox(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: SizedBox(width: 40, height: 5, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10)))))),
                const SizedBox(height: 15),
                const Text("Komentar Bab Ini", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: FutureBuilder<List<dynamic>?>(
                    future: _apiService.fetchComments(widget.storyId, widget.token),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Colors.purple));
                      if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text("Belum ada komentar.", style: TextStyle(color: Colors.grey)));
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final komen = snapshot.data![index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(komen['user']?['username'] ?? 'Pembaca', style: const TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
                            subtitle: Text(komen['content'] ?? '', style: const TextStyle(color: Colors.white70)),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Tulis komentar...",
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true, 
                            fillColor: Colors.white10,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF610094)),
                        onPressed: () async {
                          if (commentController.text.isNotEmpty) {
                            await _apiService.storeComment(token: widget.token, storyId: widget.storyId, content: commentController.text);
                            commentController.clear();
                            if (context.mounted) Navigator.pop(context);
                            _showCommentBottomSheet(); 
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✨ Langkah 1 & 2: Tangkap data profil user
    final profileVm = context.watch<ProfileViewModel>();
    final String namaUtama = profileVm.username.isNotEmpty ? profileVm.username : "Pembaca";

    final currentChapter = _chapters.isNotEmpty ? _chapters[_currentChapterIndex] : null;

    // ✨ Langkah 3: Eksekusi Trik Sulap replaceAll
    // Kita ambil teks asli, lalu pastikan itu String, lalu ganti [NAMA_USER]
    final String teksAsli = currentChapter?['content'] ?? 'Tidak ada teks isi bab.';
    final String teksSiapBaca = teksAsli.replaceAll('[NAMA_USER]', namaUtama);

    return PopScope(
      canPop: widget.isFromLibrary,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showSaveToLibraryDialog();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
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
                    // Jika cover dari DB error, bisa diganti pakai aset seperti detail_screen kalau mau
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
                      // ✨ Hasil sulapan dipasang di Widget Text ini
                      child: Text(
                        teksSiapBaca, 
                        style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.8), 
                        textAlign: TextAlign.justify
                      ),
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
      ),
    );
  }
}