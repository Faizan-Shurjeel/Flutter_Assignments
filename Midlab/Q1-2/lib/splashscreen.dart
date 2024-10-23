import 'package:flutter/material.dart';
import 'dart:async';

import 'package:project/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.flutter_dash,
                size: 80,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),
            // Progress Indicator
            const CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}
