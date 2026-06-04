import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; 
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import '../../viewmodels/profile_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  String? imagePath;

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
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 24),

                // ================= FOTO PROFILE =================
                Container(
                  padding: const EdgeInsets.all(4), 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A1B9A), Color(0xFF1976D2)], 
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withAlpha(80),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF1E1E1E), 
                    child: ClipOval(
                      child: _imageFile != null
                          ? kIsWeb
                              ? Image.network(
                                  _imageFile!.path,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _imageFile!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                          : const Icon(Icons.person, size: 40, color: Colors.white54),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  profileVM.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // ================= PEMISAH MINIMALIS =================
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50), 
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 16),

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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
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
                              loadImage(); 
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(26),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ================= FOLLOW INFO =================
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 280, 
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withAlpha(26)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  '0',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Pengikut',
                                  style: TextStyle(color: Colors.white.withAlpha(150), fontSize: 11, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.white.withAlpha(51),
                            ),
                            Column(
                              children: [
                                const Text(
                                  '0',
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Mengikuti',
                                  style: TextStyle(color: Colors.white.withAlpha(150), fontSize: 11, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ================= SETTINGS =================
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: 200, 
                    height: 40, 
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.settings, color: Colors.black87, size: 18),
                      label: const Text(
                        'Pengaturan',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9), 
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.zero, 
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
                ),

                const SizedBox(height: 10), 

                // ================= LOGOUT =================
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: 200, 
                    height: 40, 
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                      label: const Text(
                        'Keluar Akun',
                        style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.zero, 
                      ),
                      onPressed: () async {
                        
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), 
                              child: Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(28),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF161224), 
                                    borderRadius: BorderRadius.circular(24), // Sudut elegan
                                    border: Border.all(color: Colors.purpleAccent.withAlpha(80), width: 1.5), 
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purpleAccent.withAlpha(30),
                                        blurRadius: 40,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Judul Formal
                                      const Text(
                                        'Konfirmasi Keluar',
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 18, 
                                          fontWeight: FontWeight.bold, 
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      
                                      // Deskripsi Formal
                                      Text(
                                        'Apakah Anda yakin ingin keluar dari akun ini?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(180), 
                                          fontSize: 14, 
                                          height: 1.5
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      
                                      // Tombol KELUAR
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF8A2BE2), 
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
                                            elevation: 0,
                                          ),
                                          onPressed: () => Navigator.pop(context, true),
                                          child: const Text('Keluar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 12),
                                      
                                      // 🟢 Tombol BATAL
                                      SizedBox(
                                        width: double.infinity,
                                        height: 45,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          ),
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('Batal', style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        if (result != true) return;

                        final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

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
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}