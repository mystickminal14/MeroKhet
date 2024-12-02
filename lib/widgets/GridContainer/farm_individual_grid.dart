import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/view_vegetable.dart';
import 'package:merokhetapp/screens/farmers/farm_view_veg.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/indi_cate_card.dart';

class FarmIndividualGrid extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  const FarmIndividualGrid({super.key, required this.categories});

  @override
  State<FarmIndividualGrid> createState() => _FarmIndividualGridState();
}

class _FarmIndividualGridState extends State<FarmIndividualGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3 / 4,
        ),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final vegetable = category['vegetable'] ?? {};
          final farmer = category['farmer'] ?? {};
          final base64Image = vegetable['image'] ?? '';

          Uint8List? imageBytes;
          if (base64Image.isNotEmpty) {
            try {
              imageBytes = base64Decode(base64Image);
            } catch (e) {
              print("Error decoding Base64: $e");
              imageBytes = null;
            }
          }

          return IndCateCard(
            text: vegetable['name'] ?? 'Unknown Vegetable',
            img: Image.memory(
              imageBytes!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            price: vegetable['price']?.toString() ?? '0.0',
            farmer: farmer['farmAccountName'] ?? 'Unknown',
            status: 'In stock',
            onPressed: () {
              final vegetableId = vegetable['id']?.toString();
              if (vegetableId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FarmViewVeg(vegId: vegetableId),
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
            imgFarm: vegetable['image'] ?? '',
          );
        },
      ),
    );
  }
}