import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Image img;
  final String price;
  final String discounted;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.img,
    required this.price,
    required this.discounted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {}, // Default no-op if no onTap is provided
      child: Container(
        padding: const EdgeInsets.all(0),
        width: 120,
        height: 100,
        child: Card(
          elevation: 2,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Slightly rounded corners
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: img,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rs. $price per kg",
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationThickness: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Rs. $discounted per kg",
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
