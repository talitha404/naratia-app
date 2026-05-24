import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // ================= FEATURED STORY =================
          const Text(
            'Featured Story',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              children: [

                // BOOK COVER
                Container(
                  width: 100,
                  height: 150,

                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                const SizedBox(width: 16),

                // BOOK INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      const Text(
                        'What Should Be Wild',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Julia Fine',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 8,

                        children: [

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              'Romance',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              'Mystery',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ================= CONTINUE READING =================
          const Text(
            'Continue Reading',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
  height: 210,

  child: ListView(
              scrollDirection: Axis.horizontal,

              children: [

                _bookCard('Memories'),
                _bookCard('Holly Chase'),
                _bookCard('A Study in Drowning'),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ================= TRENDING =================
          const Text(
            'Trending Reads',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,

            children: [

              _trendingCard(
                title: 'Takdir Terindah',
                views: '12K',
                rank: '#1',
              ),

              _trendingCard(
                title: 'Tentang Semesta',
                views: '9K',
                rank: '#2',
              ),

              _trendingCard(
                title: 'Nightfall',
                views: '8K',
                rank: '#3',
              ),

              _trendingCard(
                title: 'Silent Moon',
                views: '7K',
                rank: '#4',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= BOOK CARD =================
  static Widget _bookCard(String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            height: 130,

            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Center(
              child: Icon(
                Icons.menu_book,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ================= TRENDING CARD =================
  static Widget _trendingCard({
    required String title,
    required String views,
    required String rank,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(16),
              ),

              child: const Center(
                child: Icon(
                  Icons.auto_stories,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(
                views,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),

              Text(
                rank,
                style: const TextStyle(
                  color: Colors.purpleAccent,
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