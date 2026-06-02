// isi metadata cerita
import 'package:flutter/material.dart';
import 'editor_screen.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk mengambil data input
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? _selectedGenre;

  // Daftar Genre (Contoh)
  final List<String> _genres = ['Romance', 'Fantasy', 'Horror', 'Sci-Fi', 'Action', 'Mystery'];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141313), // Warna background Naratia
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buat Cerita',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40), // ⬅️ tambahin bottom padding
            child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // 1. Input Judul Cerita
                _buildLabel('Judul Cerita'),
                _buildTextField(
                    controller: _titleController,
                    hint: 'Masukkan judul cerita...',
                ),
                const SizedBox(height: 20),

                // 2. Input Pilih Genre
                _buildLabel('Pilih Genre'),
                _buildDropdownField(),
                const SizedBox(height: 20),

                // 3. Input Deskripsi Singkat
                _buildLabel('Deskripsi Singkat'),
                _buildTextField(
                    controller: _descController,
                    hint: 'Tulis sinopsis atau deskripsi singkat...',
                    maxLines: 5,
                ),
                const SizedBox(height: 20),

                // 4. Area Unggah Cover
                _buildLabel('Unggah Cover'),
                _buildUploadCoverBox(),

                const SizedBox(height: 40),

                // 5. Tombol Lanjutkan Menulis
                _buildSubmitButton(),

                const SizedBox(height: 20), // ⬅️ extra ruang biar aman dari gesture bar
            ],
             ),
          ),
        ),
      ),
    );
  }

  // Widget Helper: Label Teks
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Widget Helper: Text Field Custom
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF222121),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBC84EE), width: 1.5),
        ),
      ),
    );
  }

  // Widget Helper: Dropdown Genre
  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF222121),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGenre,
          dropdownColor: const Color(0xFF222121),
          hint: const Text('Pilih Genre', style: TextStyle(color: Colors.grey, fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          isExpanded: true,
          style: const TextStyle(color: Colors.white),
          items: _genres.map((String genre) {
            return DropdownMenuItem<String>(
              value: genre,
              child: Text(genre),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedGenre = value;
            });
          },
        ),
      ),
    );
  }

  // Widget Helper: Kotak Unggah Cover
  Widget _buildUploadCoverBox() {
    return InkWell(
      onTap: () {
        // Logika untuk memilih gambar dari galeri
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF222121),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            style: BorderStyle.solid, // Bisa diganti DottedBorder jika pakai package
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Colors.white.withOpacity(0.5), size: 48),
            const SizedBox(height: 12),
            Text(
              'Klik untuk Unggah Cover',
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper: Tombol Submit dengan efek warna
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            // Berubah menjadi Ungu (#BC84EE) saat ditekan atau di-hover
            if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
              return const Color(0xFFBC84EE);
            }
            return Colors.white; // Warna default (Putih)
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
              return Colors.white;
            }
            return Colors.black; // Teks hitam saat tombol putih
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Logika untuk menyimpan data cerita dan lanjut ke EditorScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditorScreen()),
            );
          }
        },
        child: const Text(
          'Lanjutkan Menulis',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}