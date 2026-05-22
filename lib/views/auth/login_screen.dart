import 'package:naratia_app/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'cathleyaaa.s21@gmail.com');
  final _passwordController = TextEditingController(text: 'cathsukamembaca');
  bool _rememberMe = true; // Status default checkbox "Ingatkan Saya" sesuai Figma

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Warna Fill dari Figma
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  // Judul Halaman
                  const Text(
                    'Masuk Akun',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Input Email
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF7B2CBF), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Input Kata Sandi
                  const Text(
                    'Kata Sandi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF7B2CBF), width: 2),
                      ),
                      // Ikon mata (visibility) di sebelah kanan input password
                      suffixIcon: const Icon(
                        Icons.visibility_outlined,
                        color: Color(0xFF00B4D8), // Warna biru aksen ikon mata di Figma
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Baris Ingatkan Saya & Lupa Kata Sandi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ingatkan Saya (Checkbox)
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white60,
                            ),
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: const Color(0xFF7B2CBF), // Warna ungu centang
                              checkColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Ingatkan Saya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      
                      // Lupa Kata Sandi (TextButton)
                      TextButton(
                        onPressed: () {
                          // Aksi lupa kata sandi
                        },
                        child: const Text(
                          'Lupa Kata Sandi',
                          style: TextStyle(
                            color: Color(0xFF9D4EDD), // Warna ungu muda/pink lembut sesuai teks
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Tombol Masuk
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>HomeScreen(),
                            ),
                          );
                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B2CBF), // Tombol Ungu Utama
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}