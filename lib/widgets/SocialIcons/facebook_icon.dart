import 'package:flutter/material.dart';

class CustomFacebookIcon extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomFacebookIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.facebook),
      label: const Text("Facebook",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400)),
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
