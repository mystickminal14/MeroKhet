import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
       const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "poppins", // Ensure this font is added to your project
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
