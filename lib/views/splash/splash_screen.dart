import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

@override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  _animation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_controller);

  _controller.forward();

  _checkLogin();
}

  Future<void> _checkLogin() async {
    final authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);

    await authViewModel.loadToken();

    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    if (authViewModel.isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF121212),
    body: Center(
      child: FadeTransition(
        opacity: _animation,
        child: SizedBox.expand(
  child: Image.asset(
    'assets/images/logo_splash.png',
    fit: BoxFit.cover,
  ),
),
      ),
    ),
  );
}
}