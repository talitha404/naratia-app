import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_viewmodel.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'saved_stories_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProfileViewModel>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // PROFILE IMAGE
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            // USERNAME
            Consumer<ProfileViewModel>(
  builder: (context, profileVM, child) {

    return Text(
      profileVM.username,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  },
),
            const SizedBox(height: 8),

            // EMAIL
            Consumer<ProfileViewModel>(
  builder: (context, profileVM, child) {

    return Text(
      profileVM.email,
      style: const TextStyle(
        color: Colors.white70,
      ),
    );
  },
),

            const SizedBox(height: 24),

            // USER STATS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [

                Column(
                  children: [
                    Text(
                      '120',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stories',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      '2.5K',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Followers',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      '180',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Following',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // EDIT PROFILE BUTTON
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 14),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },

                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // MENU LIST
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                children: [

                  // SAVED STORIES
                  ListTile(
                    leading: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),

                    title: const Text(
                      'Saved Stories',
                      style: TextStyle(color: Colors.white),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),

                    onTap: () {

  Navigator.push(
    context,

    MaterialPageRoute(
      builder: (_) =>
          const SavedStoriesScreen(),
    ),
  );
},
                  ),

                  const Divider(color: Colors.white12),

                  // SETTINGS
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),

                    title: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(color: Colors.white12),

                  // HELP CENTER
                  ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: Colors.white,
                    ),

                    title: const Text(
                      'Help Center',
                      style: TextStyle(color: Colors.white),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),

                    onTap: () {},
                  ),

                  const Divider(color: Colors.white12),

                  // LOGOUT
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.redAccent,
                    ),

                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),

                    onTap: () {},
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