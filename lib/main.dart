import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/splash/splash_screen.dart';
import 'viewmodels/profile_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Naratia',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
        ),

        home: const SplashScreen(),
      ),
    );
  }
}