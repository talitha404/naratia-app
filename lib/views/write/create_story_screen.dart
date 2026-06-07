// isi metadata cerita
import 'dart:io';
import 'package:flutter/material.dart';
import 'editor_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/write_story_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_service.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  int? _selectedGenreId;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  List<dynamic> _genres = [];
  bool isLoadingGenres = true;

  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await ApiService().getGenres(token);

    setState(() {
      _genres = response; // ✅ langsung assign
      isLoadingGenres = false;
    });

  } catch (e) {
    print("ERROR FETCH GENRES: $e");
    setState(() => isLoadingGenres = false);
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  //dibawah ini sudah ui panjang
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF141313),
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

    // Body dengan Form Input
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  if (value.trim().length < 3) {
                    return 'Judul minimal 3 karakter';
                  }
                  return null;
                },
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

              const SizedBox(height: 20),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
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
    if (isLoadingGenres) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF222121),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _genres.any((g) => g['genre_id'] == _selectedGenreId)
              ? _selectedGenreId
              : null,
          isExpanded: true,
          dropdownColor: const Color(0xFF222121),

          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),

          hint: const Text(
            'Pilih Genre',
            style: TextStyle(color: Colors.grey),
          ),

          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

          items: _genres.map<DropdownMenuItem<int>>((genre) {
            return DropdownMenuItem<int>(
              value: genre['genre_id'],
              child: Text(
                genre['name'],
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),

          onChanged: (value) {
            setState(() {
              _selectedGenreId = value;
            });
          },
        ),
      ),
    );
  }

  // Widget Helper: Kotak Unggah Cover
  Widget _buildUploadCoverBox() {
  return InkWell(
    onTap: () async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        // simpan ke ViewModel
        context.read<WriteStoryViewModel>().setImagePath(
            pickedFile.path);
      }
    },
    borderRadius: BorderRadius.circular(16),
    child: Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF222121),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: _selectedImage == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_upload_outlined,
                    color: Colors.white.withValues(alpha: 0.5), size: 48),
                const SizedBox(height: 12),
                Text(
                  'Klik untuk Unggah Cover',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5), fontSize: 14),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                _selectedImage!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
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
        onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final vm = context.read<WriteStoryViewModel>();

          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token == null) {
            debugPrint("Token tidak ditemukan");
            return;
          }

          try {
            // 1. CREATE STORY
            final storyId = await vm.createStory(
              token: token,
              title: _titleController.text,
              description: _descController.text,
              genreId: 1,
            );

            // 2. CREATE CHAPTER 1 (pakai method baru)
            await vm.createChapter(
              token: token,
              storyId: storyId,
              title: "Bab 1",
              content: "",
            );

            await vm.fetchStories(token);

            // 3. NAVIGATE KE EDITOR
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditorScreen()),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Gagal: $e")),
            );
          }
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