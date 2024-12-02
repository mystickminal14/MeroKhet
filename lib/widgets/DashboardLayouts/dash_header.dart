import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/consumer_controller.dart';
import 'package:provider/provider.dart';

class HeaderDash extends StatefulWidget {
  final String title;
  const HeaderDash({super.key, required this.title});

  @override
  State<HeaderDash> createState() => _HeaderDashState();
}

class _HeaderDashState extends State<HeaderDash> {

  bool isLoadingConsumer = true;
  Map<String, dynamic>? consumerData;

  @override
  void initState() {
    super.initState();
    fetchConsumerData();
  }

  Future<void> fetchConsumerData() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      if (user != null) {
        final data = await ConsumerController().getConsumerByID(user.uid);
        setState(() {
          consumerData = data.isNotEmpty ? data[0]['consumer'] : null;
        });
      }
    } catch (e) {
      print("Error fetching consumer data: $e");
    } finally {
      setState(() {
        isLoadingConsumer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image = consumerData?['image'] ?? ''; // Use the correct key here

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
