import 'dart:convert'; // For base64Decode
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/BestDeals/best_deals.dart';

class ListViewBestDeals extends StatefulWidget {
  final List<Map<String, dynamic>> bestDeals;

  const ListViewBestDeals({
    super.key,
    required this.bestDeals,
  });

  @override
  State<ListViewBestDeals> createState() => _ListViewBestDealsState();
}

class _ListViewBestDealsState extends State<ListViewBestDeals> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.bestDeals.length > 5 ? 5 : widget.bestDeals.length,
        itemBuilder: (context, index) {
          final deal = widget.bestDeals[index]['vegetable'];
          final base64Image = deal['image'] ?? '';

          Uint8List? imageBytes;
          if (base64Image.isNotEmpty) {
            try {
              imageBytes = base64Decode(base64Image);
            } catch (e) {
              print("Error decoding Base64: $e");
              imageBytes = null;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CustomCard(
              img:  Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
                width: 120,
                height: 50,
              ), // Fallback placeholder for invalid/missing images
              price: deal['price'].toString(),
              discounted: deal['discountedPrice'].toString(),
              onTap: () {
                print('Selected: ${deal['name']}');
              },
            ),
          );
        },
      ),
    );
  }
}
