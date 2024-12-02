import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/IndividualCategory/individual_category.dart';
import '../DashboardLayouts/CustomCategories/categories_card.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Map<String, String>> categories = [
      {'text': 'Leafy Greens', 'img': 'assets/Leaf.png'},
      {'text': 'Root Veg', 'img': 'assets/Leaf.png'},
      {'text': 'Cruciferous', 'img': 'assets/Leaf.png'},
      {'text': 'Allium', 'img': 'assets/Leaf.png'},
      {'text': 'Legumes', 'img': 'assets/Leaf.png'},
      {'text': 'Tubers', 'img': 'assets/Leaf.png'},
      {'text': 'Spanish Varieties', 'img': 'assets/Leaf.png'},
      {'text': 'Herbs and Spices', 'img': 'assets/Leaf.png'},
      {'text': 'Mushrooms', 'img': 'assets/Leaf.png'},
      {'text': 'Fruits Veg', 'img': 'assets/Leaf.png'},

    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoriesCard(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  IndividualCategory(category:categories[index]['text']),
              ),
            );
          },
          text: categories[index]['text']!,
          img: categories[index]['img']!,
        );
      },
    );
  }
}
