import 'package:flutter/material.dart';

class CustomOutlinedBack extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomOutlinedBack({super.key, required this.text, required this.onPressed});


  @override
  State<CustomOutlinedBack> createState() => _CustomOutlinedBackState();
}

class _CustomOutlinedBackState extends State<CustomOutlinedBack> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );;
  }
}
