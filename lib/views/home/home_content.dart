import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notification/notification_screen.dart';
import '../detail/detail_screen.dart'; 
import '../baca/baca_screen.dart';
import '../../viewmodels/library_viewmodel.dart';
import '../../viewmodels/home_viewmodel.dart';

class HomeContent extends StatefulWidget {
  final Function(int)? onNavigate;

  const HomeContent({super.key, this.onNavigate});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchStories();
    });
  }

  String _getAuthorName(String title, String fallback) {
    String t = title.toUpperCase();
    if (t == 'TAKDIR TERINDAH') return 'Raisa Violet';
    if (t == 'A THEORY DREAMING') return 'Luna Fawn';
    if (t == 'WHAT SHOULD BE WILD') return 'Kaelen Roe';
    if (t == 'REWRITING MEMORIES') return 'Cora Sterling';
    if (t == 'AFTERLIFE') return 'Dante Vane';
    return (fallback == 'Anonim' || fallback.isEmpty) ? 'Raisa Violet' : fallback;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeVm, _) {
        if (homeVm.isLoading && homeVm.stories.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: Colors.purple));
        }

        final List<dynamic> trendingStories = homeVm.stories.where((item) {
          final String title = (item['title'] ?? '').toString().toUpperCase();
          return title != 'A THEORY DREAMING' && 
                 title != 'WHAT SHOULD BE WILD' && 
                 title != 'REWRITING MEMORIES' && 
                 title != 'AFTERLIFE';
        }).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Naratia', style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.white),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text('Cerita unggulan', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              if (trendingStories.isNotEmpty) ...[
                Builder(
                  builder: (context) {
                    final featured = trendingStories.first;
                    final int safeStoryId = int.tryParse(featured['id'].toString()) ?? 1;
                    final String judulFeatured = featured['title'] ?? 'No Title';
                    final String authorFeatured = _getAuthorName(judulFeatured, featured['author'] ?? 'Anonim'); 

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              storyId: safeStoryId,
                              title: judulFeatured,
                              imagePath: 'assets/images/book5.png', 
                              synopsis: featured['synopsis'] ?? '',
                              authorName: authorFeatured,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            Container(
                              width: 90, height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(image: AssetImage('assets/images/book5.png'), fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(judulFeatured, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 6),
                                  Text(authorFeatured, style: const TextStyle(color: Colors.white70)), 
                                  const SizedBox(height: 10),
                                  Row(children: [_tag('Romantis'), const SizedBox(width: 6), _tag('Misteri')]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ] else ...[
                const Text('Belum ada cerita unggulan.', style: TextStyle(color: Colors.white54)),
              ],
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Lanjut baca', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(onTap: () => widget.onNavigate?.call(1), child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)),
                ],
              ),
              const SizedBox(height: 12),

              // ✨ INI TERSANGKANYA! Tingginya sudah aku kembalikan jadi 185 biar gak sesak
              SizedBox(
                height: 185, 
                child: Consumer<LibraryViewModel>(
                  builder: (context, vm, _) {
                    final libraryStories = vm.stories.take(3).toList();
                    if (libraryStories.isEmpty) return const Center(child: Text('Library kosong', style: TextStyle(color: Colors.white54)));

                    return ListView.builder(
                      scrollDirection: Axis.horizontal, itemCount: libraryStories.length,
                      itemBuilder: (context, index) {
                        final story = libraryStories[index]; 
                        final String authorLibrary = _getAuthorName(story.title, 'Anonim');
                        return _BookCard(storyId: index + 2, title: story.title, image: story.image, synopsis: story.description, author: authorLibrary);
                      },
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 8),

              const Text('Bacaan trending', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              if (trendingStories.isNotEmpty) ...[
                GridView.builder(
                  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.72),
                  itemCount: trendingStories.length,
                  itemBuilder: (context, index) {
                    final item = trendingStories[index];
                    final int safeStoryId = int.tryParse(item['id'].toString()) ?? 1;
                    final String judulTrending = item['title'] ?? 'No Title';
                    final String authorTrending = _getAuthorName(judulTrending, item['author'] ?? 'Anonim');
                    
                    String coverImage = item['cover_image'] ?? '';
                    if (coverImage.isEmpty || coverImage == 'null') {
                      List<String> defaultCovers = ['assets/images/book1.png', 'assets/images/book2.png', 'assets/images/book3.png', 'assets/images/book4.png'];
                      coverImage = defaultCovers[index % defaultCovers.length];
                      if (judulTrending.toUpperCase() == 'TAKDIR TERINDAH') coverImage = 'assets/images/book5.png';
                    }

                    return _TrendingCard(
                      storyId: safeStoryId, 
                      title: judulTrending, 
                      views: '12K', rank: '#${index + 1}', 
                      image: coverImage, 
                      synopsis: item['synopsis'] ?? '', 
                      author: authorTrending,
                    );
                  },
                ),
              ] else ...[
                const Center(child: Text('Belum ada data trending.', style: TextStyle(color: Colors.white54))),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
  );
}

class _BookCard extends StatelessWidget {
  final int storyId; final String title; final String image; final String synopsis; final String author;
  const _BookCard({required this.storyId, required this.title, required this.image, this.synopsis = '', required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BacaScreen(
          storyId: storyId, 
          storyTitle: title, 
          coverUrl: image, 
          token: '', 
          isFromLibrary: true, 
        )));
      },
      child: Container(
        width: 95, margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 130, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: image.startsWith('http') ? NetworkImage(image) : AssetImage(image) as ImageProvider, fit: BoxFit.cover))),
            const SizedBox(height: 6),
            Text(title, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.3, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final int storyId; final String title; final String views; final String rank; final String image; final String synopsis; final String author;
  const _TrendingCard({required this.storyId, required this.title, required this.views, required this.rank, required this.image, required this.synopsis, required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
          storyId: storyId, title: title, imagePath: image, synopsis: synopsis, authorName: author,
        )));
      },
      child: Container(
        padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: image.startsWith('http') ? Image.network(image, fit: BoxFit.cover, width: double.infinity, errorBuilder: (c, e, s) => Image.asset('assets/images/book1.png', fit: BoxFit.cover, width: double.infinity)) : Image.asset(image, fit: BoxFit.cover, width: double.infinity, errorBuilder: (c, e, s) => Image.asset('assets/images/book1.png', fit: BoxFit.cover, width: double.infinity)))),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(views, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                Text(rank, style: const TextStyle(color: Colors.purpleAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}