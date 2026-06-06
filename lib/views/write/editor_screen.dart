import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewmodels/write_story_viewmodel.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isInitialized = false;
  String? _token;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadToken();

    _contentController.addListener(_onContentChanged);
    _titleController.addListener(_onTitleChanged);
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  void _onContentChanged() {
    final vm = context.read<WriteStoryViewModel>();

    if (_token == null) return;
    if (vm.currentChapter == null) return;

    vm.autoSave(
      token: _token!,
      content: _contentController.text,
    );
  }

  void _onTitleChanged() {
    final vm = context.read<WriteStoryViewModel>();

    if (vm.currentChapter == null) return;

    vm.updateChapterTitle(_titleController.text);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final vm = context.read<WriteStoryViewModel>();

      _titleController.text = vm.currentChapter?.title ?? "";
      _contentController.text = vm.currentChapter?.content ?? "";

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    final choice = await _showPublishDialog();

    if (choice == null) return; // user cancel

    await _submit(choice);
  }

  Future<String?> _showPublishDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Simpan Cerita"),
          content: const Text("Pilih tipe penyimpanan"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, "draft"),
              child: const Text("Draft"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "publish"),
              child: const Text("Publish"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit(String status) async {
    final vm = context.read<WriteStoryViewModel>();

    if (_token == null) return;
    if (vm.currentChapter == null) return;

    setState(() => _isSubmitting = true);

    try {
      // UPDATE CHAPTER (INI YANG PENTING)
      await vm.autoSave(
        token: _token!,
        content: _contentController.text,
      );

      // OPTIONAL: update status story (draft/publish)
      await vm.updateStoryStatus(
        token: _token!,
        storyId: vm.currentStoryId!,
        status: status,
      );

      if (!mounted) return;

      if (status == "publish") {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Draft disimpan")),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WriteStoryViewModel>();

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
          'Tulis Chapter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _onSavePressed,
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Color(0xFFBC84EE),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: vm.currentChapter == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // ✅ JUDUL CHAPTER
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Judul Chapter',
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),

                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),

                  const SizedBox(height: 16),

                  // ✅ CONTENT
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.6,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'Mulai tulis cerita... (gunakan y/n untuk nama pembaca)',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.2),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

      // BOTTOM TOOLBAR harusnya ada untuk akses cepat ke fitur seperti preview, tapi untuk sekarang kita fokus ke editor dulu
    );
  }
}