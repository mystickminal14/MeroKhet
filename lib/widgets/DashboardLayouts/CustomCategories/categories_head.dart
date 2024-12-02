import 'package:flutter/material.dart';

class CustomCatHead extends StatefulWidget {
  const CustomCatHead({super.key});

  @override
  State<CustomCatHead> createState() => _CustomCatHeadState();
}

class _CustomCatHeadState extends State<CustomCatHead> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Categories",
          style: TextStyle(
              fontFamily: 'poppins-semi'
          ),
        )
      ],
    );
  }
}
