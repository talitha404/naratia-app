// halaman riwayat cerita pengguna
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/library_viewmodel.dart';
import '../baca/baca_screen.dart'; 

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Background gelap Figma
      body: Consumer<LibraryViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.stories.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada riwayat cerita.",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Center(
            child: SizedBox(
              width: 360,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: GridView.builder(
                  itemCount: viewModel.stories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final story = viewModel.stories[index];

                    // ✨ LOGIKA DETEKTOR JUDUL (Biar ID-nya akurat dan ceritanya beda-beda!)
                    int targetStoryId = story.id ?? 1;
                    String judul = story.title.toUpperCase();
                    if (judul == 'TAKDIR TERINDAH') targetStoryId = 1;
                    else if (judul == 'A THEORY DREAMING') targetStoryId = 2;
                    else if (judul == 'WHAT SHOULD BE WILD') targetStoryId = 3;
                    else if (judul == 'REWRITING MEMORIES') targetStoryId = 4;
                    else if (judul == 'AFTERLIFE') targetStoryId = 5;

                    return GestureDetector(
                      onTap: () {
                        viewModel.selectStory(story);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BacaScreen(
                              storyId: targetStoryId, // ✨ Menggunakan ID yang sudah dijamin benar
                              storyTitle: story.title,
                              coverUrl: story.image,
                              token: '',                      
                              isFromLibrary: true,            
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: story.image.startsWith('http')
                                      ? NetworkImage(story.image) as ImageProvider
                                      : AssetImage(story.image) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Teks Judul
                          Center(
                            child: Text(
                              story.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}