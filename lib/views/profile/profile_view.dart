import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // PROFILE IMAGE
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/profile_placeholder.png',
                ),
              ),

              const SizedBox(height: 16),

              // USERNAME
              const Text(
                "Fransisca",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // EMAIL
              const Text(
                "fransisca@email.com",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              // EDIT BUTTON
              ElevatedButton(
                onPressed: () {},
                child: const Text("Edit Profile"),
              ),

              const SizedBox(height: 32),

              // MENU
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text("Saved Stories"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text("Help Center"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}