import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/indi_cate_card.dart';

class IndividualCategoryGrid extends StatefulWidget {
  const IndividualCategoryGrid({super.key});

  @override
  State<IndividualCategoryGrid> createState() => _IndividualCategoryGridState();
}

class _IndividualCategoryGridState extends State<IndividualCategoryGrid> {
  final List<Map<String, String>> categories = [
    {'text': 'Cauliflower', 'img': 'assets/F.jpg'},
    {'text': 'Broccoli', 'img': 'assets/F.jpg'},
    {'text': 'Spinach', 'img': 'assets/F.jpg'},
    {'text': 'Tomato', 'img': 'assets/F.jpg'}, {'text': 'Cauliflower', 'img': 'assets/F.jpg'},
    {'text': 'Broccoli', 'img': 'assets/F.jpg'},
    {'text': 'Spinach', 'img': 'assets/F.jpg'},
    {'text': 'Tomato', 'img': 'assets/F.jpg'},
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(

        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8, // Spacing between columns
          mainAxisSpacing: 8, // Spacing between rows
          childAspectRatio: 3 / 4, // Adjust the aspect ratio as needed
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return IndCateCard(
            text: category['text'] ?? '',
            img: category['img'] ?? '',
            onPressed: () {
              print('${category['text']} tapped');
            },
          );
        },
      ),
    );
  }
}
