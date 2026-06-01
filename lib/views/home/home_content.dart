import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notification/notification_screen.dart';
import '../../viewmodels/library_viewmodel.dart';

class HomeContent extends StatelessWidget {
  final Function(int)? onNavigate;

  const HomeContent({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
              IconButton(
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
            ],
          ),

          const SizedBox(height: 20),

          // ================= CERITA UNGGULAN =================
          const Text(
            'Cerita unggulan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What Should be Wild',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

          const SizedBox(height: 24),

          // ================= LANJUT BACA =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lanjut baca',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  onNavigate?.call(1);
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🔥 LIST DARI VIEWMODEL
SizedBox(
  height: 200,
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
          final story = stories[index]; // ✅ FIX

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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
children: const [
  _TrendingCard(
    title: 'Takdir Terindah',
    views: '12K',
    rank: '#1',
    image: 'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?w=500',
  ),

  _TrendingCard(
    title: 'Tentang Semesta',
    views: '9K',
    rank: '#2',
    image: 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=500',
  ),

  _TrendingCard(
    title: 'Nightfall',
    views: '8K',
    rank: '#3',
    image: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=500',
  ),

  _TrendingCard(
    title: 'Silent Moon',
    views: '7K',
    rank: '#4',
    image: 'https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=500',
  ),
],
          ),
        ],
      ),
    );
  }
}

// ================= TAG =================
Widget _tag(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image, // ✅ FIX DI SINI
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
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
    );
  }
}