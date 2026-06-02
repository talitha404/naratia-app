import 'package:flutter/material.dart';

class BacaScreen extends StatelessWidget {
  final String title;
  final bool isAlreadyInLibrary; // Saklar penentu (true = sudah ada di library, false = belum)

  const BacaScreen({
    super.key, 
    required this.title,
    this.isAlreadyInLibrary = false,
  });

  // Fungsi untuk memunculkan Pop-up Peringatan (Confirmation Dialog)
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            "Simpan ke Library?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: const Text(
            "Apakah kamu ingin menyimpan novel ini ke Library? Jika memilih TIDAK, riwayat membaca dan chapter terakhirmu tidak akan tersimpan.",
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
          actions: [
            // TOMBOL TIDAK
            TextButton(
              onPressed: () => Navigator.pop(context, false), 
              child: const Text(
                "TIDAK",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            // TOMBOL IYA, SIMPAN
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7512B6), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.pop(context, true), 
              child: const Text(
                "IYA, SIMPAN",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  } 

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isAlreadyInLibrary, 
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return; 

        // Kode ini hanya berjalan jika buku BELUM ada di library
        final bool mauSimpan = await _showExitConfirmationDialog(context);
        if (context.mounted) {
          if (mauSimpan) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil disimpan ke Library!")),
            );
          }
          Navigator.pop(context); 
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        
        // ================= APPBAR =================
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () async {
              if (isAlreadyInLibrary) {
                Navigator.pop(context);
              } else {
                final bool mauSimpan = await _showExitConfirmationDialog(context);
                if (context.mounted) {
                  if (mauSimpan) {
                  }
                  Navigator.pop(context);
                }
              }
            },
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 24), 
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),

        // ================= SIDEBAR CHAPTER =================
        endDrawer: Drawer(
          backgroundColor: const Color(0xFF161616), 
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Daftar Chapter",
                        style: TextStyle(
                          color: Color(0xFF8E24AA), 
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white12, height: 1),

                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: 8, 
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white.withValues(alpha: 0.05), 
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Color(0xFF8E24AA), 
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        title: Text(
                          "Chapter ${index + 1}: Kelanjutan...",
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text(
                          "DREAMING",
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        onTap: () {
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

        // ================= BODY =================
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),

        // ================= BOTTOM BAR =================
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 65,
            color: const Color(0xFF7512B6), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.white, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}