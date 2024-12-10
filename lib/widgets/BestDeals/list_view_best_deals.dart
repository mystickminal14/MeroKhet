import 'dart:convert'; // For base64Decode
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/view_vegetable.dart';
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

    final filteredDeals = widget.bestDeals.where((deal) {
      final discountedPrice = deal['vegetable']['discountedPrice'];
      return discountedPrice != null && discountedPrice.isNotEmpty;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(0),
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredDeals.length > 5 ? 5 : filteredDeals.length,
        itemBuilder: (context, index) {
          final deal = filteredDeals[index]['vegetable'];
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
              img: imageBytes != null
                  ? Image.memory(
                imageBytes,
                fit: BoxFit.cover,
                width: 120,
                height: 60,
              )
                  : Image.asset(
                'assets/placeholder.png', // Fallback placeholder
                fit: BoxFit.cover,
                width: 120,
                height: 50,
              ),
              price: deal['price'].toString(),
              discounted: deal['discountedPrice'].toString(),
              onTap: () {
                final vegetableId = deal['id']?.toString();
                if (vegetableId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewVegetable(vegId: vegetableId),
                    ),
                  );
                } else {
                  print("Error: Vegetable ID is null");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error: Unable to view vegetable details'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
