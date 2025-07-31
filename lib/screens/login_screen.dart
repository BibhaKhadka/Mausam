import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
          icon: const Icon(Icons.login, color: Colors.blue),
          label: const Text("Sign in with Google"),
          onPressed: () async {
            print("Sign-in button pressed");

            final user = await authService.signInWithGoogle();

            if (user != null) {
              print("Login successful: ${user.email}");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            } else {
              print("Login failed or was cancelled by user.");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sign-in failed")),
              );
            }
          },
        ),
      ),
    );
  }
}
