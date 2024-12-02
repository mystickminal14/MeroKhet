import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/CategoryBlock.dart';

class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  State<CustomCategories> createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryBlock(
               text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
               text: "Root Veg", img: "assets/Leaf.png"),
          CategoryBlock(
               text: "Cruciferous", img: "assets/Leaf.png"),
          CategoryBlock(
               text: "Allium", img: "assets/Leaf.png"),
          CategoryBlock(
              text: "Legumes", img: "assets/Leaf.png"),
          CategoryBlock(
               text: "Tubers", img: "assets/Leaf.png"),
          CategoryBlock(
              text: "Squash Varieties", img: "assets/Leaf.png"),
          CategoryBlock(
             text: "Herbs and Spicy", img: "assets/Leaf.png"),
          CategoryBlock(
              text: "Mushrooms", img: "assets/Leaf.png"),
        ],
      ),
    );
  }
}
