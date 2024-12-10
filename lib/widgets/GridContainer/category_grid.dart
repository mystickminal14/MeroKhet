import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/IndividualCategory/individual_category.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/categories_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => IndividualCategory(
                  category: categories[index]['text']!,
                ),
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
