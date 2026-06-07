import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewmodels/write_story_viewmodel.dart';
import 'editor_screen.dart';

class DraftListScreen extends StatefulWidget { //sampe sini perlu gimana caranya buat namipilin daftar cerita draft milik penulisnya saja bukan semua cerita draft yang ada
  const DraftListScreen({super.key});

  @override
  State<DraftListScreen> createState() => _DraftListScreenState();
}

class _DraftListScreenState extends State<DraftListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _token;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadTokenAndFetchDrafts();
  }

  Future<void> _loadTokenAndFetchDrafts() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');

    if (!mounted || _token == null) return;

    final vm = context.read<WriteStoryViewModel>();
    await vm.fetchStories(_token!);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Future<void> _openEditor() async {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token tidak ditemukan')),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditorScreen()),
    );

    if (result != null && _token != null) {
      final vm = context.read<WriteStoryViewModel>();
      await vm.fetchStories(_token!);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WriteStoryViewModel>();

    final filteredDrafts = _searchQuery == null || _searchQuery!.isEmpty
        ? vm.draftStories
        : vm.draftStories.where((draft) {
            return draft.title.toLowerCase().contains(_searchQuery!.toLowerCase());
          }).toList();

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
          'Draf Cerita',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () async {
              if (_token != null) {
                await context.read<WriteStoryViewModel>().fetchStories(_token!);
              }
            },
            tooltip: 'Segarkan Draf',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF222121),
                hintText: 'Cari Draf...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.4)),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1B1B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    if (vm.isLoading) ...[
                      const Center(child: CircularProgressIndicator()),
                      const SizedBox(height: 16),
                    ],
                    if (!vm.isLoading && filteredDrafts.isEmpty) ...[
                      const Text(
                        'Tidak ada draf saat ini.',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Simpan cerita sebagai draft dan kartu draf akan muncul di sini.',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                    if (!vm.isLoading) ...filteredDrafts.map((draft) {
                      return _buildDraftCard(
                        imageUrl: draft.image.isNotEmpty ? draft.image : 'https://via.placeholder.com/150',
                        title: draft.title.isNotEmpty ? draft.title : 'Draft Baru',
                        genre: draft.description.isNotEmpty ? draft.description : 'Tanpa Genre',
                        lastEdited: draft.id != null ? 'ID: ${draft.id}' : 'Draft belum disimpan',
                        onEditTap: _openEditor,
                        onDeleteTap: () {
                          context.read<WriteStoryViewModel>().removeDraftLocally(draft.id);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Kartu Item Draf Cerita
  Widget _buildDraftCard({
    required String imageUrl,
    required String title,
    required String genre,
    required String lastEdited,
    required VoidCallback onEditTap,
    required VoidCallback onDeleteTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF242323), // Kontainer abu gelap bagian dalam draf
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Thumbnail Cerita
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 70,
                  color: Colors.grey,
                  child: const Icon(Icons.image, color: Colors.white30, size: 20),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          
          // Informasi Detail Cerita
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // Tag Genre Mini
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    genre,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Informasi Kapan Terakhir Diedit & Tombol Aksi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lastEdited,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 26,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF323131),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: onEditTap,
                            icon: const Icon(Icons.edit, size: 12, color: Color(0xFFBC84EE)),
                            label: const Text('Edit', style: TextStyle(fontSize: 11)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 26,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF881515),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: onDeleteTap,
                            icon: const Icon(Icons.delete, size: 12),
                            label: const Text('Delete', style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}