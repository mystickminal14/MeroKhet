import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/IndividualCategory/individual_category.dart';
import 'package:merokhetapp/services/products.dart';

class CategoryBlock extends StatefulWidget {

  final String text, img;
  const CategoryBlock({
    super.key,
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
      onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  IndividualCategory(category:widget.text),
            ),
          );
      },
      child: Card(
        elevation: 2,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Container(
          width: 60,  // Set width to 40
          height:80, // Set height to 40
       padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              Image.asset(
                widget.img,
                fit: BoxFit.cover,
                width: 60,
                height: 45, 
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
