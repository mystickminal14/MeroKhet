import 'package:flutter/material.dart';

class CustomGoogleIcon extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomGoogleIcon({super.key, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.facebook), // The icon to be displayed
      label: const Text("Google",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400)), // The text to be displayed
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        fixedSize: const Size(150, 32),
      ),
    );
  }
}
