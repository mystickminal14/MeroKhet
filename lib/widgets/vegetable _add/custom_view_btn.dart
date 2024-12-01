import 'package:flutter/material.dart';

class CustomViewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final double width;
  final IconData? icon;

  const CustomViewButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF4B6F39),
    this.width = 80.0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        minimumSize: MaterialStatePropertyAll(
          Size(width, 45),
        ),
        backgroundColor: MaterialStatePropertyAll(buttonColor),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      icon: icon != null
          ? Icon(
        icon,
        color: Colors.white,
        size: 18
      )
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
