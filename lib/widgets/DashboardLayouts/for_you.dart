import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/farmers/view_vegetable.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/indi_cate_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForYou extends StatefulWidget {
  final List<Map<String, dynamic>> vegetables;
  const ForYou({super.key, required this.vegetables});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3 / 4,
        ),
        itemCount: widget.vegetables.length,
        itemBuilder: (context, index) {
          final category = widget.vegetables[index];

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
            text: vegetable['name'] ?? '',
            img: Image.memory(
              imageBytes!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            price: vegetable['price'] ?? 0.0,
            farmer: farmer['farmAccountName'] ?? 'Unknown',
            status: 'In stock',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewVegetable(vegId: vegetable['id']),
                ),
              );
            },
            imgFarm: vegetable['image'] ?? '',
          );
        },
      ),
    );
  }
}
