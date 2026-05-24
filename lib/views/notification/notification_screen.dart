import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,

        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: const [

          NotificationCard(
            message:
                'Halo! Bacaanmu menunggu! Apa kamu ada waktu?',
          ),

          NotificationCard(
            message:
                'Chapter baru dari "Rewriting Stories" sudah rilis, baca sekarang!',
          ),

          NotificationCard(
            message:
                '🔥 Sedang trending: "My Fairy"',
          ),

          NotificationCard(
            message:
                'Karena kamu suka y/n, coba baca "Tentang Semesta!"',
          ),

          NotificationCard(
            message:
                'Cerita "Why Don’t We" lagi ramai dibaca pengguna lain!',
          ),

          NotificationCard(
            message:
                'Sudah beberapa hari kamu tidak membaca, ayo lanjutkan!',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;

  const NotificationCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // ICON
          Container(
            width: 50,
            height: 50,

            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.menu_book,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 16),

          // MESSAGE
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}