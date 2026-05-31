import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController =
      TextEditingController(text: 'cathleyaaa.s21@gmail.com');

  final _passwordController =
      TextEditingController(text: 'akunmembaca123');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),

              const Text(
                'Daftar Akun',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // EMAIL
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
                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: const BorderSide(
                      color: Color(0xFF7B2CBF),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // PASSWORD
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

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: const BorderSide(
                      color: Color(0xFF7B2CBF),
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),

                    borderSide: const BorderSide(
                      color: Color(0xFF7B2CBF),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // BUTTON DAFTAR
              SizedBox(
                width: double.infinity,
                height: 48,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7B2CBF),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}