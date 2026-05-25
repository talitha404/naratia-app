import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text("Settings"),
      ),

      body: ListView(
        children: [

          ListTile(
            leading: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
            title: const Text(
              'Dark Mode',
              style: TextStyle(color: Colors.white),
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
              'Notifications',
              style: TextStyle(color: Colors.white),
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
              'Privacy',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
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