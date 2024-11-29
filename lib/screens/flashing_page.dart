import 'package:flutter/material.dart';
import 'dart:async';

class FlashingPage extends StatefulWidget {
  const FlashingPage({super.key});

  @override
  State<FlashingPage> createState() => _FlashingPageState();
}

class _FlashingPageState extends State<FlashingPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
//made by charitra shrestha
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B6F39),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/flashingmerokhet.png',
            ),
          ],
        ),
      ),
    );
  }
}