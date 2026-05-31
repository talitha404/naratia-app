import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  final TextEditingController emailController =
    TextEditingController();

  final TextEditingController characterController =
    TextEditingController();

  @override
  void initState() {
    super.initState();

    final profileVM =
        Provider.of<ProfileViewModel>(
          context,
          listen: false,
        );

    usernameController.text = profileVM.username;
    emailController.text = profileVM.email;
  }

  @override
  Widget build(BuildContext context) {

    final profileVM =
        Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
  backgroundColor: const Color(0xFF121212),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  title: const Text(
    'Edit Profil',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple,

              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // USERNAME FIELD
            TextField(
              controller: usernameController,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(
                labelText: 'Username',

                labelStyle: const TextStyle(
                  color: Colors.white70,
                ),

                filled: true,
                fillColor: const Color(0xFF1E1E1E),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

TextField(
  controller: characterController,

  style: const TextStyle(
    color: Colors.white,
  ),

  decoration: InputDecoration(
    labelText: 'Nama Karakter',

    labelStyle: const TextStyle(
      color: Colors.white70,
    ),

    filled: true,
    fillColor: const Color(0xFF1E1E1E),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
),

            const SizedBox(height: 16),

TextField(
  controller: emailController,

  style: const TextStyle(
    color: Colors.white,
  ),

  decoration: InputDecoration(
    labelText: 'Email',

    labelStyle: const TextStyle(
      color: Colors.white70,
    ),

    filled: true,
    fillColor: const Color(0xFF1E1E1E),

    border: OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(14),
    ),
  ),
),

const SizedBox(height: 16),

            // BIO FIELD
            TextField(
              controller: bioController,

              style: const TextStyle(
                color: Colors.white,
              ),

              maxLines: 3,

              decoration: InputDecoration(
                labelText: 'Bio',

                labelStyle: const TextStyle(
                  color: Colors.white70,
                ),

                filled: true,
                fillColor: const Color(0xFF1E1E1E),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                ),

                onPressed: () async {

                  await profileVM.saveUsername(
                    usernameController.text,
                  );

                  await profileVM.saveEmail(
  emailController.text,
);

                  if (context.mounted) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Profile updated!',
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  }
                },

                child: const Text(
                  'Simpan Perubahan',

                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}