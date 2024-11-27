import 'package:flutter/material.dart';

class IndCateCard extends StatefulWidget {
  final String text, img;
  final VoidCallback onPressed;
  const IndCateCard({
    super.key,
    required this.text,
    required this.img,
    required this.onPressed,
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
          borderRadius: BorderRadius.circular(6), // Slightly rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
              child: Image.asset(
                widget.img,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
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
                  // Price and Rating Row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rs.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                          Text(
                            '100',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_rate_outlined, size: 12),
                          Text(
                            '4.3',
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
                  // Farm Info Row
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: AssetImage('assets/F.jpg'),
                            maxRadius: 8, // Smaller avatar
                          ),
                          SizedBox(width: 5),
                          Text(
                            'James Farm',
                            style: TextStyle(
                              fontSize: 9,
                              fontFamily: 'Poppins-SemiBold',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '5kg sold',
                        style: TextStyle(
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
