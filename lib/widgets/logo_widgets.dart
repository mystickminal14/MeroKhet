import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0), // Add margin for spacing
      child: const Image(
        image: AssetImage('assets/meroKhetLogo.png'),
        fit: BoxFit.cover,
        width: 180,
        height: 80,
      ),
    );
  }
}
