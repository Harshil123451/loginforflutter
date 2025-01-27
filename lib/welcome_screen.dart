import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF64B5F6),
              Color(0xFF1E88E5),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildLogo(),
                const SizedBox(height: 48),
                _buildWelcomeText(),
                const SizedBox(height: 16),
                _buildSubText(),
                const Spacer(),
                _buildLoginButton(context, screenSize),
                const SizedBox(height: 16),
                _buildSignupButton(context, screenSize),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.9),
      ),
      child: const Icon(
        Icons.flutter_dash,
        size: 100,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      'Welcome to Flutter Auth',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubText() {
    return const Text(
      'Your secure authentication solution',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginButton(BuildContext context, Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context, Size screenSize) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, '/signup'),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 