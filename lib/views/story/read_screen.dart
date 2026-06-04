import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/reader_viewmodel.dart';

class ReadScreen extends StatefulWidget {
  final int storyId;
  final String token;

  const ReadScreen({
    super.key,
    required this.storyId,
    required this.token,
  });

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final vm = context.read<ReaderViewModel>();

      vm.fetchChapters(
        token: widget.token,
        storyId: widget.storyId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReaderViewModel>();

    final chapter = vm.currentChapter;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())

          : chapter == null
              ? const Center(
                  child: Text(
                    "Chapter tidak ditemukan",
                    style: TextStyle(color: Colors.white),
                  ),
                )

              : Column(
                  children: [

                    // 🔥 TITLE (pakai parsedTitle biar support y/n)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        vm.parsedTitle.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // 🔥 CONTENT
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          vm.parsedContent,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),

                    // 🔥 NAVIGATION + ACTION BAR
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFF610094),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          // PREV
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: vm.currentIndex > 0
                                ? vm.previousChapter
                                : null,
                          ),

                          // LIKE
                          IconButton(
                            icon: const Icon(Icons.favorite_border, color: Colors.white),
                            onPressed: () {},
                          ),

                          // NEXT
                          IconButton(
                            icon: const Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: vm.currentIndex < vm.chapters.length - 1
                                ? vm.nextChapter
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}