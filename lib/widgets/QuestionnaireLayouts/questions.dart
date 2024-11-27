import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String title, question, ans;
  const Questions(
      {super.key,
        required this.title,
        required this.question,
        required this.ans});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            return Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "poppins-bold",
                  fontSize: screenWidth * 0.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            question,
            style: const TextStyle(
              fontFamily: "poppins",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            ans,
            style: const TextStyle(
              fontFamily: "poppins",
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
