import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io'; // 1. Added dart:io for File handling
import 'package:image_picker/image_picker.dart'; // 2. Added image_picker
import 'package:shared_preferences/shared_preferences.dart'; // 3. Added shared_preferences
import 'package:flutter/foundation.dart'; // For kIsWeb check to avoid errors

import '../../viewmodels/profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  
  // Controller tambahan buat contoh isi data antara Nama dan Bio
  final TextEditingController emailController = TextEditingController(); 

  File? _imageFile; // 4. Moved state from profile_screen.dart
  String? imagePath; // 5. Moved state from profile_screen.dart

  // ================= 6. PICK IMAGE FUNCTION (MOVED) =================
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

  // ================= 7. LOAD IMAGE FUNCTION (MOVED) =================
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

    final profileVM = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    );

    usernameController.text = profileVM.username;
    nameController.text = profileVM.name;
    bioController.text = profileVM.bio;

    // Tambahin data contoh buat email
    emailController.text = "user_email@example.com"; 

    // 8. Call load image on initialization to show current photo
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    // profileVM is used ininitState, so we keep build minimal.

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              // ================= 9. INTERACTIVE PROFILE IMAGE (REPLACED) =================
              GestureDetector(
                onTap: _pickImage, // Call pickImage function when tapped
                child: Container(
                  padding: const EdgeInsets.all(4), // Jarak untuk border gradient
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A1B9A), Color(0xFF1976D2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: _imageFile != null
                          ? kIsWeb
                              // ✅ Handling image display on Web
                              ? Image.network(
                                  _imageFile!.path,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              // ✅ Handling image display on Android/iOS
                              : Image.file(
                                  _imageFile!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                          // Placeholder icon when no image is picked
                          : Icon(Icons.add_a_photo, size: 30, color: Colors.grey[700]), 
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= USERNAME =================
              _buildFieldLabel('Username'),
              const SizedBox(height: 8),
              _buildTextField(usernameController),

              const SizedBox(height: 20),

              // ================= NAMA =================
              _buildFieldLabel('Nama'),
              const SizedBox(height: 8),
              _buildTextField(nameController),

              // ================= 10. NEW: BETWEEN NAME AND BIO =================
              // Kita tambahin Email buat pemisah yang fungsional
              const SizedBox(height: 20),
              _buildFieldLabel('Email'),
              const SizedBox(height: 8),
              _buildTextField(emailController, enabled: false), // Disabled text field (read-only)

              const SizedBox(height: 20),

              // ================= BIO =================
              _buildFieldLabel('Bio'),
              const SizedBox(height: 8),
              _buildTextField(bioController),

              const SizedBox(height: 30),

              // ================= SIMPAN BUTTON =================
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Logic simpan ke ViewModel akan jalan di sini
                    // Navigator.pop(context); // Pindah halaman setelah simpan
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Jarak ekstra di bawah biar gak mepet
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for consistent labels
  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper widget for consistent text fields
  Widget _buildTextField(TextEditingController controller, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled, // Dynamic enabled state
      style: const TextStyle(color: Colors.black87), // Style for input text
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFD9D9D9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder( // Style when disabled
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}