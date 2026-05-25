import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/bookmark_viewmodel.dart';

class SavedStoriesScreen extends StatefulWidget {
  const SavedStoriesScreen({super.key});

  @override
  State<SavedStoriesScreen> createState() =>
      _SavedStoriesScreenState();
}

class _SavedStoriesScreenState
    extends State<SavedStoriesScreen> {

@override
void initState() {
  super.initState();

  Future.microtask(() async {

    final bookmarkVM =
        context.read<BookmarkViewModel>();

    await bookmarkVM.loadBookmarks();
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),

        title: const Text(
          'Saved Stories',
        ),
      ),

      body: Consumer<BookmarkViewModel>(
        builder: (
          context,
          bookmarkVM,
          child,
        ) {

          // EMPTY STATE
          if (bookmarkVM.savedStories.isEmpty) {

            return const Center(
              child: Text(
                'No saved stories yet',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            );
          }

          // LIST BOOKMARK
          return ListView.builder(
            itemCount:
                bookmarkVM.savedStories.length,

            itemBuilder: (context, index) {

              final story =
                  bookmarkVM.savedStories[index];

              return Card(
                color: const Color(0xFF1E1E1E),

                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                child: ListTile(

                  leading: const Icon(
                    Icons.book,
                    color: Colors.purple,
                  ),

                  title: Text(
                    story,

                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  trailing: IconButton(

                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),

                    onPressed: () {

                      bookmarkVM.removeBookmark(
                        story,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}