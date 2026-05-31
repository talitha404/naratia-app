import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/splash/splash_screen.dart';
import 'views/home/home_screen.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/bookmark_viewmodel.dart';
import 'viewmodels/library_viewmodel.dart';
import 'viewmodels/search_viewmodel.dart'; // Ini baris yang baru ditambahkan
import 'viewmodels/auth_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarkViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => LibraryViewModel(),
        ),
        // Ini provider baru untuk fitur Search kamu
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Naratia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),

        // ⬇️ TAMBAHKAN INI
        routes: {
          '/home': (context) => const HomeScreen(),
        },

        home: const SplashScreen(),
      ),
    );
  }
}