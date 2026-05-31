import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Pengaturan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: ListView(
        children: [

          ListTile(
            leading: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
            title: const Text(
              'Mode Gelap',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            title: const Text(
              'Notifikasi',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.lock_outline,
              color: Colors.white,
            ),
            title: const Text(
              'Privasi',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}