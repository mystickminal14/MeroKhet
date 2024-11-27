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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
          CategoryBlock(
              onPressed: () {}, text: "Leafy Greens", img: "assets/Leaf.png"),
        ],
      ),
    );
  }
}
