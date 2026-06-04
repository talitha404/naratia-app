import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notification/notification_screen.dart';
import '../detail/detail_screen.dart'; 
import '../../viewmodels/library_viewmodel.dart';

class HomeContent extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomeContent({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
  horizontal: 16,
  vertical: 20,
),
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

          // 🔥 BUNGKUS DENGAN GESTURE DETECTOR
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(
                    title: 'What Should be Wild',
                    imagePath: 'assets/images/book1.png',
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
  image: AssetImage(
    'assets/images/book1.png',
  ),
  fit: BoxFit.cover,
),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
  'What Should be Wild',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
),
                        const SizedBox(height: 6),
                        const Text(
                          'Julia Fine',
                          style: TextStyle(color: Colors.white70),
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
          ),

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
    onNavigate?.call(1);
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

          // 🔥 LIST DARI VIEWMODEL
          SizedBox(
            height: 170,
            child: Consumer<LibraryViewModel>(
              builder: (context, vm, _) {
                // ✅ FILTER buang "What Should Be Wild" + ambil 3
                final stories = vm.stories
                    .where((e) => e.title != 'WHAT SHOULD BE WILD')
                    .take(3)
                    .toList();

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index]; 

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

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,
            children: const [
              _TrendingCard(
                title: 'Takdir Terindah',
                views: '12K',
                rank: '#1',
                image: 'assets/images/book5.png',
              ),
              _TrendingCard(
                title: 'Tentang Semesta',
                views: '9K',
                rank: '#2',
                image: 'assets/images/book6.png',
              ),
              _TrendingCard(
                title: 'Nightfall',
                views: '8K',
                rank: '#3',
                image: 'assets/images/book7.png',
              ),
              _TrendingCard(
                title: 'Silent Moon',
                views: '7K',
                rank: '#4',
                image: 'assets/images/book8.png',
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
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

  const _BookCard({
    required this.title,
    required this.image,
  });

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
                  image: AssetImage(image),
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
  final String title;
  final String views;
  final String rank;
  final String image;

  const _TrendingCard({
    required this.title,
    required this.views,
    required this.rank,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 BUNGKUS DENGAN GESTURE DETECTOR
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              imagePath: image,
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
  image,
  fit: BoxFit.cover,
)
              ),
            ),
            const SizedBox(height: 8),
            Text(
  title,
  textAlign: TextAlign.center,
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