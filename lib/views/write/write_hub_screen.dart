import 'package:flutter/material.dart';
import 'create_story_screen.dart';
import 'draft_list_screen.dart';
import 'published_list_screen.dart';

class WriteHubScreen extends StatelessWidget {
  const WriteHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141313),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),

            // 1. Tombol Buat Cerita Baru
            _buildMenuButton(
              context: context,
              icon: Icons.note_add_outlined,
              title: 'Buat Cerita Baru',
              subtitle: 'Mulai Tulis Cerita Baru',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateStoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 2. Tombol Draf Cerita
            _buildMenuButton(
              context: context,
              icon: Icons.insert_drive_file_outlined,
              title: 'Draf Cerita',
              subtitle: 'Kelola dan Lanjutkan Draf Anda',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DraftListScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 3. Tombol Cerita Terpublikasi
            _buildMenuButton(
              context: context,
              icon: Icons.cloud_done_outlined,
              title: 'Cerita Terpublikasi',
              subtitle: 'Lihat Karya yang Sudah Rilis',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PublishedListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget
  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF222121),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}