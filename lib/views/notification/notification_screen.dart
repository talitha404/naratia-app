import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(message: 'Halo! Bacaanmu menunggu!'),
          NotificationCard(message: 'Chapter baru sudah rilis!'),
          NotificationCard(message: '🔥 Sedang trending: My Fairy'),
          NotificationCard(message: 'Coba baca Tentang Semesta'),
          NotificationCard(message: 'Why Don’t We lagi ramai!'),
          NotificationCard(message: 'Ayo lanjutkan bacaanmu!'),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;

  const NotificationCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Naratia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}