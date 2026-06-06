import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notification/notification_screen.dart';
import '../detail/detail_screen.dart'; 
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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeVm, _) {
        if (homeVm.isLoading && homeVm.stories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Naratia',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================= CERITA UNGGULAN =================
              const Text(
                'Cerita unggulan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (homeVm.stories.isNotEmpty) ...[
                Builder(
                  builder: (context) {
                    final featured = homeVm.stories.first;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              storyId: featured['id'] ?? 1,
                              title: featured['title'] ?? 'No Title',
                              imagePath: featured['cover_image'] ?? 'assets/images/book5.png',
                              synopsis: featured['synopsis'] ?? 'Tidak ada sinopsis.',
                              authorName: featured['author'] ?? 'Anonim',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 90,
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/book5.png'), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    featured['title'] ?? 'No Title',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    featured['author'] ?? 'Anonim',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      _tag('Romantis'),
                                      const SizedBox(width: 6),
                                      _tag('Misteri'),
                                    ],
                                  ),
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

              // ================= LANJUT BACA =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lanjut baca',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onNavigate?.call(1);
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 170,
                child: Consumer<LibraryViewModel>(
                  builder: (context, vm, _) {
                    final libraryStories = vm.stories
                        .where((e) => e.title != 'WHAT SHOULD BE WILD')
                        .take(3)
                        .toList();

                    if (libraryStories.isEmpty) {
                      return const Center(child: Text('Library kosong', style: TextStyle(color: Colors.white54)));
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: libraryStories.length,
                      itemBuilder: (context, index) {
                        final story = libraryStories[index]; 
                        return _BookCard(
                          title: story.title,
                          image: story.image,
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // ================= TRENDING =================
              const Text(
                'Bacaan trending',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              if (homeVm.stories.isNotEmpty) ...[
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: homeVm.stories.length,
                  itemBuilder: (context, index) {
                    final item = homeVm.stories[index];
                    return _TrendingCard(
                      storyId: item['id'] ?? 1,
                      title: item['title'] ?? 'No Title',
                      views: '12K', 
                      rank: '#${index + 1}',
                      image: item['cover_image'] ?? 'assets/images/book5.png',
                      synopsis: item['synopsis'] ?? 'Tidak ada sinopsis.',
                      author: item['author'] ?? 'Anonim',
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

// ================= TAG =================
Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );
}

// ================= BOOK CARD =================
class _BookCard extends StatelessWidget {
  final String title;
  final String image;

  const _BookCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imagePath: image,
              synopsis: 'Ini cerita dari Library lokal.',
              authorName: 'Layla.one',
            ),
          ),
        );
      },
      child: Container(
        width: 95,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: image.startsWith('http') ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1.3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= TRENDING CARD =================
class _TrendingCard extends StatelessWidget {
  final int storyId;
  final String title;
  final String views;
  final String rank;
  final String image;
  final String synopsis;
  final String author;

  const _TrendingCard({
    required this.storyId,
    required this.title,
    required this.views,
    required this.rank,
    required this.image,
    required this.synopsis,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              storyId: storyId,
              title: title,
              imagePath: image,
              synopsis: synopsis,
              authorName: author,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/book5.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  views,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  rank,
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}