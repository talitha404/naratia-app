import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:flutter/foundation.dart'; 

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
  final TextEditingController emailController = TextEditingController(); 

  File? _imageFile; 
  String? imagePath; 

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);

      setState(() {
        _imageFile = File(pickedFile.path);
        imagePath = pickedFile.path;
      });
    } catch (e) {
      if (kDebugMode) print("Error pick image: $e");
    }
  }

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
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);

    usernameController.text = profileVM.username;
    nameController.text = profileVM.name;
    bioController.text = profileVM.bio;
    emailController.text = "user_email@example.com"; 

    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Edit Profil', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage, 
                child: Container(
                  padding: const EdgeInsets.all(4), 
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
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
                              ? Image.network(_imageFile!.path, width: 100, height: 100, fit: BoxFit.cover)
                              : Image.file(_imageFile!, width: 100, height: 100, fit: BoxFit.cover)
                          : Icon(Icons.add_a_photo, size: 30, color: Colors.grey[700]), 
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildFieldLabel('Username'),
              const SizedBox(height: 8),
              _buildTextField(usernameController),

              const SizedBox(height: 20),

              _buildFieldLabel('Nama'),
              const SizedBox(height: 8),
              _buildTextField(nameController),

              const SizedBox(height: 20),
              
              _buildFieldLabel('Email'),
              const SizedBox(height: 8),
              _buildTextField(emailController, enabled: false), 

              const SizedBox(height: 20),

              _buildFieldLabel('Bio'),
              const SizedBox(height: 8),
              _buildTextField(bioController),

              const SizedBox(height: 30),

              SizedBox(
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    // Logika API Rindi digabung ke tombol estetik punyamu
                    final success = await profileVM.updateProfile(
                      usernameController.text.trim(),
                      nameController.text.trim(),
                      bioController.text.trim(),
                    );

                    if (!context.mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil berhasil diperbarui')));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal memperbarui profil')));
                    }
                  },
                  child: const Text('Simpan', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 40), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextField(TextEditingController controller, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled, 
      style: const TextStyle(color: Colors.black87), 
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFD9D9D9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}