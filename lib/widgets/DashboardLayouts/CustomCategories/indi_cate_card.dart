import 'package:flutter/material.dart';

class IndCateCard extends StatefulWidget {
  final String text, price, farmer, status, imgFarm;
  final Image img; // Change this to a Widget to handle both Image types
  final VoidCallback onPressed;

  const IndCateCard({
    super.key,
    required this.text,
    required this.img,
    required this.price,
    required this.farmer,
    required this.status,
    required this.onPressed,
    required this.imgFarm,
  });

  @override
  State<IndCateCard> createState() => _IndCateCardState();
}

class _IndCateCardState extends State<IndCateCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              child: widget.img, // Use the passed widget here
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins-SemiBold',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Rs.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                          Text(
                            widget.price,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.red,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star_rate_outlined, size: 12),
                          Text(
                             '0',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            foregroundImage: AssetImage('assets/F.jpg'),
                            maxRadius: 8,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.farmer,
                            style: const TextStyle(
                              fontSize: 9,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.status,
                        style: const TextStyle(
                          fontSize: 9,
                          fontFamily: 'Poppins-SemiBold',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
