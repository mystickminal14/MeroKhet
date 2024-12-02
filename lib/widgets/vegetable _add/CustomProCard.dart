import 'package:flutter/material.dart';
import '../DashboardLayouts/CustomCategories/categories_card.dart';

class CustomProCard extends StatelessWidget {
  const CustomProCard({super.key});

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
            Navigator.pushNamed(context, '/individual_category');
          },
          text: categories[index]['text']!,
          img: categories[index]['img']!,
        );
      },
    );
  }
}
