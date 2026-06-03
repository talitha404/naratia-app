import 'package:flutter/material.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String cacheSize = '5,1 MB';
  String downloadSize = '2,5 MB';

  void clearCache() {
    setState(() {
      cacheSize = '0 MB';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cache berhasil dibersihkan'),
      ),
    );
  }

  void clearDownloads() {
    setState(() {
      downloadSize = '0 MB';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unduhan berhasil dihapus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Penyimpanan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Kosongkan Ruang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hapus Cache:',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cacheSize,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: clearCache,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Bersihkan',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hapus Unduhan:',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      downloadSize,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                ElevatedButton(
                  onPressed: clearDownloads,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Bersihkan',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
                          ),
          ],
        ),
      ),
    ),
  ),
    );
  }
}