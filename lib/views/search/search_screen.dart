import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/search_viewmodel.dart';
import '../detail/detail_screen.dart';

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
        _searchController.text,
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

    if (viewModel.currentState == SearchState.initial &&
        _searchController.text.isNotEmpty) {
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(viewModel),
                  const SizedBox(height: 20),
                  _buildSearchBar(viewModel),
                  const SizedBox(height: 30),
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
                padding: const EdgeInsets.only(right: 12),
                constraints: const BoxConstraints(),
                onPressed: () {
                  _searchController.clear();
                  viewModel.resetSearch();
                  _searchFocusNode.unfocus();
                },
              ),
            const Text(
              'NARATIA',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(SearchViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(51)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            onSubmitted: (value) {
              viewModel.submitSearch(value);
              _searchFocusNode.unfocus();
            },
            decoration: const InputDecoration(
              hintText: 'Cari Novel, Genre, atau Penulis...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = screenWidth > 800 ? 5 : (screenWidth > 600 ? 3 : 2);

    final List<Map<String, String>> daftarGenreLengkap = [
      {
        'name': 'Romantis',
        'img': 'https://picsum.photos/seed/romantis/300/200',
      },
      {'name': 'Fantasi', 'img': 'https://picsum.photos/seed/fantasi/300/200'},
      {
        'name': 'Kehidupan',
        'img': 'https://picsum.photos/seed/kehidupan/300/200',
      },
      {'name': 'Horor', 'img': 'https://picsum.photos/seed/horor/300/200'},
      {
        'name': 'Fanfiction',
        'img': 'https://picsum.photos/seed/fanfiction/300/200',
      },
      {'name': 'Drama', 'img': 'https://picsum.photos/seed/drama/300/200'},
      {
        'name': 'Detektif',
        'img': 'https://picsum.photos/seed/detektif/300/200',
      },
      {
        'name': 'Petualangan',
        'img': 'https://picsum.photos/seed/petualangan/300/200',
      },
      {
        'name': 'Thriller',
        'img': 'https://picsum.photos/seed/thriller/300/200',
      },
      {
        'name': 'Fiksi Remaja',
        'img': 'https://picsum.photos/seed/fiksiremaja/300/200',
      },
      {'name': 'Komedi', 'img': 'https://picsum.photos/seed/komedi/300/200'},
      {'name': 'Aksi', 'img': 'https://picsum.photos/seed/aksi/300/200'},
      {'name': 'Sci-Fi', 'img': 'https://picsum.photos/seed/scifi/300/200'},
      {'name': 'Misteri', 'img': 'https://picsum.photos/seed/misteri/300/200'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PENCARIAN POPULER',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
          ),
          itemCount: daftarGenreLengkap.length,
          itemBuilder: (context, index) {
            final genre = daftarGenreLengkap[index];

            return GestureDetector(
              onTap: () {
                _searchController.text = genre['name']!;
                viewModel.submitSearch(genre['name']!);
                _searchFocusNode.unfocus();
              },
              child: PhysicalModel(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                elevation: 6,
                shadowColor: Colors.black.withAlpha(180),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(genre['img']!),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.black54,
                        BlendMode.darken,
                      ),
                    ),
                    border: Border.all(color: Colors.white.withAlpha(26)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    genre['name']!.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
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
        const Text(
          'PENCARIAN SEBELUMNYA',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: viewModel.history.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final keyword = viewModel.history[index];

            return InkWell(
              onTap: () {
                _searchController.text = keyword;
                viewModel.submitSearch(keyword);
                _searchFocusNode.unfocus();
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(13),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withAlpha(13)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.history, color: Colors.grey, size: 18),
                    const SizedBox(width: 12),
                    Text(
                      keyword,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
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
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 16),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            _buildResultCard(
              'A THEORY DREAMING',
              'AYA_REID',
              'Freya menyimpan rahasia kutukan...',
              'https://picsum.photos/seed/search_result1/300/400',
              ['ROMANTIS', 'FANTASI'],
            ),
            const SizedBox(height: 12),
            _buildResultCard(
              'WHAT SHOULD BE WILD',
              'JULIA_FINE',
              'Kekuatan aneh di dalam hutan...',
              'https://picsum.photos/seed/search_result2/300/400',
              ['MISTERI'],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultCard(
    String title,
    String author,
    String desc,
    String imgUrl,
    List<String> tags,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imagePath: imgUrl,
              authorName: author,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withAlpha(26)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    author,
                    style: const TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
