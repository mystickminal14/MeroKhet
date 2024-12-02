import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/farmer_controller.dart';
import 'package:provider/provider.dart';

class FarmHead extends StatefulWidget {
  final String title;
  const FarmHead({super.key, required this.title});

  @override
  State<FarmHead> createState() => _FarmHeadState();
}

class _FarmHeadState extends State<FarmHead> {

  bool isLoadingfarmer = true;
  Map<String, dynamic>? farmerData;

  @override
  void initState() {
    super.initState();
    fetchfarmerData();
  }

  Future<void> fetchfarmerData() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      if (user != null) {
        final data = await FarmerController().getFarmerByID(user.uid);
        setState(() {
          farmerData = data.isNotEmpty ? data[0]['farmer'] : null;
        });
      }
    } catch (e) {
      print("Error fetching farmer data: $e");
    } finally {
      setState(() {
        isLoadingfarmer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image = farmerData?['image'] ?? ''; // Use the correct key here

    Uint8List? imageBytes;
    if (base64Image.isNotEmpty) {
      try {
        imageBytes = base64Decode(base64Image);
      } catch (e) {
        print("Error decoding Base64: $e");
        imageBytes = null;
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(0), // Add margin for spacing
              child: const Image(
                image: AssetImage('assets/Leaf.png'),
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins-semi',
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 4,
            ),
            CircleAvatar(
              foregroundImage: imageBytes != null
                  ? MemoryImage(imageBytes!)
                  : const AssetImage('assets/F.jpg'),
              maxRadius: 20,
            ),
          ],
        ),
      ],
    );
  }
}
