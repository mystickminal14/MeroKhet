import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CustomTiles extends StatefulWidget {
  final String text, price, img;
 final VoidCallback onPressed;
  const CustomTiles({
    super.key,
    required this.img,
    required this.text,
    required this.price, required this.onPressed,
  });

  @override
  State<CustomTiles> createState() => _CustomTilesState();
}

class _CustomTilesState extends State<CustomTiles> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    if (widget.img.isNotEmpty) {
      try {
        imageBytes = base64Decode(widget.img);
      } catch (e) {
        print("Error decoding Base64: $e");
        imageBytes = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            leading: CircleAvatar(
              foregroundImage: imageBytes != null
                  ? MemoryImage(imageBytes!) // Use MemoryImage if base64 is decoded
                  : AssetImage(widget.img) as ImageProvider, // Default to AssetImage
              maxRadius: 20,
            ),
            title: Text(
              widget.text,
              style: const TextStyle(
                fontFamily: 'poppins-semi',
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              widget.price,
              style: const TextStyle(
                fontFamily: 'poppins',
                fontSize: 10,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
