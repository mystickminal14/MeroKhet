import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(0),
        width: 120,
        height: 100,
        child: Card(
          elevation: 2,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                    image: AssetImage('assets/F.jpg'),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 78,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 1),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                  Text(
                    "Rs. 220 per kg",
                    style: TextStyle(
                      fontFamily: 'poppins-semi',
                      fontSize: 7,
                      decoration: TextDecoration.lineThrough,
                      decorationColor:
                          Colors.red, // Changes the color of the line
                      decorationThickness:
                          2.0, // Changes the thickness of the line
                    ),
                  ),
                  Text(
                    "Rs. 180 per kg",
                    style: TextStyle(fontFamily: 'poppins-semi', fontSize: 8),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
