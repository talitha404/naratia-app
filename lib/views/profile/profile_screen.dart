import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? _imageFile;
  String? imagePath;

  // ================= PICK IMAGE =================
Future<void> _pickImage() async {
  try {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', pickedFile.path);

    setState(() {
      _imageFile = File(pickedFile.path);
      imagePath = pickedFile.path;
    });
  } catch (e) {
    print("Error pick image: $e");
  }
}

  // ================= LOAD IMAGE =================
Future<void> loadImage() async {
  final prefs = await SharedPreferences.getInstance();

  final path = prefs.getString('profile_image');

  if (path != null && path.isNotEmpty) {
    setState(() {
      imagePath = path;
      _imageFile = File(path);
    });
  }
}

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProfileViewModel>().loadUser();
    });

    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileVM, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [

                Text(
                  '@${profileVM.username}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

// ================= FOTO PROFILE =================
GestureDetector(
  onTap: _pickImage,
  child: CircleAvatar(
    radius: 50,
    backgroundColor: Colors.grey[300],
    child: ClipOval(
      child: _imageFile != null
          ? kIsWeb
              // ✅ WEB
              ? Image.network(
                  _imageFile!.path,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              // ✅ ANDROID / IOS
              : Image.file(
                  _imageFile!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
          : Icon(Icons.camera_alt, size: 30, color: Colors.grey[700]),
    ),
  ),
),

                const SizedBox(height: 12),

                Text(
                  profileVM.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Tap foto untuk mengganti',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),

// ================= BIO =================
Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Bio',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              ),
            );

            if (mounted) {
              context.read<ProfileViewModel>().loadUser();
            }
          },
          child: const Icon(
            Icons.edit,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ],
    ),

    const SizedBox(height: 6),

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        profileVM.bio.isNotEmpty
            ? profileVM.bio
            : 'Tambahkan bio...',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
        ),
      ),
    ),
  ],
),

                const SizedBox(height: 25),

                // ================= FOLLOW INFO =================
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Pengikut',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),

                    SizedBox(width: 70),

                    Column(
                      children: [
                        Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mengikuti',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ================= SETTINGS =================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.settings, color: Colors.black87),
                    label: const Text(
                      'Pengaturan',
                      style: TextStyle(color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9D9D9),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 14),

                // ================= LOGOUT =================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout, color: Colors.black87),
                    label: const Text(
                      'Keluar Akun',
                      style: TextStyle(color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Keluar Akun'),
                            content: const Text(
                              'Apakah Anda ingin keluar dari akun ini?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        },
                      );

                      if (result != true) return;

                      final authViewModel =
                          Provider.of<AuthViewModel>(context, listen: false);

                      await authViewModel.logout();

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/welcome',
                          (route) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}