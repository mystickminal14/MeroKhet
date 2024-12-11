import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/IndividualCategory/individual_category.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/categories_card.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/farmer_indi_cat.dart';

class CustomerProCard extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CustomerProCard({super.key, required this.categories});

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
                builder: (context) => FarmerIndiCat(
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
