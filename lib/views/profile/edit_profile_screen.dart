import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final profileVM =
        Provider.of<ProfileViewModel>(
      context,
      listen: false,
    );

    usernameController.text =
        profileVM.username;

    nameController.text =
        profileVM.name;

    bioController.text =
        profileVM.bio;
  }

  @override
  Widget build(BuildContext context) {
    final profileVM =
        Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [

            const SizedBox(height: 10),

            const CircleAvatar(
              radius: 42,
              backgroundColor:
                  Color(0xFFD9D9D9),
              child: Icon(
                Icons.person_add_alt_1,
                color: Colors.black54,
                size: 28,
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Username',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller:
                  usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    const Color(0xFFD9D9D9),
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          10),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Nama',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    const Color(0xFFD9D9D9),
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          10),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Bio',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: bioController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    const Color(0xFFD9D9D9),
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          10),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 140,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.purple,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            10),
                  ),
                ),
onPressed: () async {
  await profileVM.saveUsername(
    usernameController.text.trim(),
  );

  await profileVM.saveName(
    nameController.text.trim(),
  );

  await profileVM.saveBio(
    bioController.text.trim(),
  );

  await profileVM.loadUser();

  if (context.mounted) {
    Navigator.pop(context);
  }
},
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}