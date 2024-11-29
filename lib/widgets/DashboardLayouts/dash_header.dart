import 'package:flutter/material.dart';

class HeaderDash extends StatefulWidget {
  final String title;
  const HeaderDash({super.key, required this.title});

  @override
  State<HeaderDash> createState() => _HeaderDashState();
}

class _HeaderDashState extends State<HeaderDash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(0), // Add margin for spacing
              child: const Image(
                image: AssetImage('assets/Leaf.png'),
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins-semi',
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 4,
            ),

             const CircleAvatar(
              foregroundImage: AssetImage('assets/F.jpg'),
              maxRadius: 20,
            ),
          ],
        ),

      ],
    );
  }
}
