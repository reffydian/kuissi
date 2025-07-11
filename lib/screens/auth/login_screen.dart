import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Welcome\nBack',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'example@email.com',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '••••••••',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[700],
                padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: const Text('Log in'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // nanti bisa diarahkan ke register
              },
              child: const Text.rich(
                TextSpan(
                  text: "Don't have account? ",
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
