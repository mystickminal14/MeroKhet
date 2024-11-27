import 'package:flutter/material.dart';

class QuestionnaireHeader extends StatelessWidget {
  final VoidCallback onPressed;

  const QuestionnaireHeader({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10), // Add margin for spacing
          child: const Image(
            image: AssetImage('assets/meroKhetLogo.png'),
            fit: BoxFit.cover,
            width: 150,
            height: 70,
          ),
        ),
        IconButton(
            onPressed:onPressed,
            icon: const Icon(Icons.arrow_back_ios_new_outlined))
      ],
    );
  }
}
