import 'package:flutter/material.dart';

class CategoryBlock extends StatefulWidget {
  final VoidCallback onPressed;
  final String text, img;

  const CategoryBlock({
    super.key,
    required this.onPressed,
    required this.text,
    required this.img,
  });

  @override
  State<CategoryBlock> createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Container(
          width: 60,  // Set width to 40
          height:60, // Set height to 40
       padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              Image.asset(
                widget.img,  // Use the passed image
                fit: BoxFit.cover,
                width: 60,  // Adjust image width
                height: 45, // Adjust image height
              ),

              Text(
                widget.text,
                style: const TextStyle(fontSize: 8), // Adjust font size for better fit
                textAlign: TextAlign.center, // Center the text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
