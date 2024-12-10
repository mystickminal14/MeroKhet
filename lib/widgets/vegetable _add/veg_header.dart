import 'package:flutter/material.dart';

class VegHeader extends StatefulWidget {
  final String title;
  final String route;

  const VegHeader({super.key, required this.title, required this.route});

  @override
  State<VegHeader> createState() => _VegHeaderState();
}

class _VegHeaderState extends State<VegHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(0), // Add margin for spacing
            child: const Image(
              image: AssetImage('assets/Leaf.png'),
              fit: BoxFit.cover,
              width: 60,
              height: 70,
            ),
          ),

          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "poppins",
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, widget.route);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ), // Placeholder for alignment
        ],
      ),
    );
  }
}
