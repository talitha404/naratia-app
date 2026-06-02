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
  double _logoScale = 1.0; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    _controller.repeat();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await authViewModel.loadToken();
    await Future.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;
    await _controller.animateTo(
      1.0, 
      duration: const Duration(milliseconds: 400), 
      curve: Curves.easeOut,
    );

    if (!mounted) return;
    setState(() {
      _logoScale = 1.3; 
    });
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // 6. 🚀 PINDAH HALAMAN
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
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/bg_cosmic_splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _logoScale,
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.elasticOut, 
                  
                  child: RotationTransition(
                    turns: _animation,
                    child: SizedBox(
                      width: 140, 
                      height: 140,
                      child: Image.asset(
                        'assets/images/logo_splash.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 200), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}