import 'package:flutter/material.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

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
          'Hubungkan Sosial Media',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
  child: SingleChildScrollView(
    child: Center(
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hubungkan Sosmed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Temukan kami di Sosial Media favorit Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 30),

_socialButton(
  context,
  'Instagram',
  Icons.camera_alt,
),

const SizedBox(height: 16),

_socialButton(
  context,
  'TikTok',
  Icons.music_note,
),

const SizedBox(height: 16),

_socialButton(
  context,
  'X / Twitter',
  Icons.close,
),
                        ],
          ),
        ),
      ),
    ),
  ),
    );
  }

static Widget _socialButton(
  BuildContext context,
  String title,
  IconData icon,
) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$title Fitur ini masih dalam tahap pengembangan',
            ),
          ),
        );
      },

      icon: Icon(
        icon,
        color: Colors.white,
      ),

      label: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
  }
