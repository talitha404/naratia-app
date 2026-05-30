import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/search_viewmodel.dart';
import '../../views/notification/notification_screen.dart'; 

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      context.read<SearchViewModel>().onSearchFocusChanged(
        _searchFocusNode.hasFocus, 
        _searchController.text
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();

    // Jika state kembali ke initial (karena klik tombol nav atau back), kosongkan kolom teks
    if (viewModel.currentState == SearchState.initial && _searchController.text.isNotEmpty) {
      _searchController.clear();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF02040F),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/stardust.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(viewModel),
                  const SizedBox(height: 20), // Jarak diperkecil
                  _buildSearchBar(viewModel),
                  const SizedBox(height: 24),
                  _buildDynamicContent(viewModel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(SearchViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (viewModel.currentState != SearchState.initial)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22), 
                padding: const EdgeInsets.only(right: 12),
                constraints: const BoxConstraints(),
                onPressed: () {
                  _searchController.clear();
                  viewModel.resetSearch();
                  _searchFocusNode.unfocus();
                }
              ),
            const Text(
              'NARATIA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -1.0, color: Colors.white),
            ),
          ],
        ),
        // Ikon search sudah dihapus, tinggal notifikasi saja
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white, size: 22), 
          onPressed: () {
            // Arahkan ke NotificationScreen saat diklik
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          }
        ),
      ],
    );
  }
  
  Widget _buildSearchBar(SearchViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20), // Radius diperkecil
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            style: const TextStyle(color: Colors.white, fontSize: 14), // Teks lebih kecil
            onSubmitted: (value) {
              viewModel.submitSearch(value);
              _searchFocusNode.unfocus();
            },
            decoration: const InputDecoration(
              hintText: 'Cari Novel, Genre, atau Penulis...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              // Kotak search bar diperkecil tinggi dan paddingnya
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16), 
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicContent(SearchViewModel viewModel) {
    switch (viewModel.currentState) {
      case SearchState.initial:
        return _buildGenreGrid(viewModel);
      case SearchState.history:
        return _buildHistory(viewModel);
      case SearchState.results:
        return _buildResults(viewModel);
    }
  }

  Widget _buildGenreGrid(SearchViewModel viewModel) {
    // Mengecek lebar layar untuk menentukan jumlah kolom secara dinamis
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = screenWidth > 800 ? 5 : (screenWidth > 600 ? 3 : 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PENCARIAN POPULER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2.0)),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, // Dinamis! Di laptop jadi lebih banyak kotak kecil
            crossAxisSpacing: 12, 
            mainAxisSpacing: 12, 
            childAspectRatio: 2.0, // Membuat kotaknya lebih pipih dan proporsional
          ),
          itemCount: viewModel.genres.length,
          itemBuilder: (context, index) {
            final genre = viewModel.genres[index];
            return GestureDetector(
              onTap: () {
                _searchController.text = genre['name']!;
                viewModel.selectKeyword(genre['name']!, isGenre: true);
                _searchFocusNode.unfocus();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  image: DecorationImage(
                    image: NetworkImage(genre['img']!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(genre['name']!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHistory(SearchViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PENCARIAN SEBELUMNYA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2.0)),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: viewModel.history.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _searchController.text = viewModel.history[index];
                viewModel.selectKeyword(viewModel.history[index]);
                _searchFocusNode.unfocus();
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Diperkecil
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.history, color: Colors.grey, size: 18),
                    const SizedBox(width: 12),
                    Text(viewModel.history[index], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildResults(SearchViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.resultTitle.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.indigoAccent, letterSpacing: 2.0),
        ),
        const SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            _buildResultCard('A THEORY DREAMING', 'AYA_REID', 'Freya menyimpan rahasia kutukan...', 'https://picsum.photos/seed/search_result1/300/400', ['ROMANTIS', 'FANTASI']),
            const SizedBox(height: 12),
            _buildResultCard('WHAT SHOULD BE WILD', 'JULIA_FINE', 'Kekuatan aneh di dalam hutan...', 'https://picsum.photos/seed/search_result2/300/400', ['MISTERI']),
          ],
        ),
      ],
    );
  }

  Widget _buildResultCard(String title, String author, String desc, String imgUrl, List<String> tags) {
    return Container(
      padding: const EdgeInsets.all(12), // Padding diperkecil
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), 
            child: Image.network(imgUrl, width: 60, height: 90, fit: BoxFit.cover) // Gambar diperkecil drastis
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1), // Font diperkecil
                const SizedBox(height: 2),
                Text(author, style: const TextStyle(color: Colors.indigoAccent, fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6, 
                  children: tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), 
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), 
                    child: Text(tag, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w900))
                  )).toList()
                ),
                const SizedBox(height: 6),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11), maxLines: 2),
              ],
            ),
          )
        ],
      ),
    );
  }
}