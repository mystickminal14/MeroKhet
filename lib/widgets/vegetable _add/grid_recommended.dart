import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/tile.dart';

class GridRecommended extends StatelessWidget {
  const GridRecommended({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Map<String, String>> categories = [
      {'text': 'Leafy Greens', 'img': '/assets/F.jpg', 'price': 'Rs. 440'},
      {'text': 'Root Veg', 'img': 'assets/Leaf.png', 'price': 'Rs. 400'},
      {'text': 'Cruciferous', 'img': 'assets/Leaf.png', 'price': 'Rs. 420'},
      {'text': 'Allium', 'img': 'assets/Leaf.png', 'price': 'Rs. 390'},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        // Extract data for the current item
        final category = categories[index];
        final img = category['img'] ?? '';
        final text = category['text'] ?? '';
        final price = category['price'] ?? '';

        return CustomTiles(
          img: img,
          text: text,
          price: price,
        );
      },
    );
  }
}
