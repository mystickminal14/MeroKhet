import 'package:flutter/material.dart';

class CustomTiles extends StatefulWidget {
  final String img,text,price;
  const CustomTiles({super.key, required this.img, required this.text, required this.price});

  @override
  State<CustomTiles> createState() => _CustomTilesState();
}

class _CustomTilesState extends State<CustomTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width / 2.1,
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          leading: CircleAvatar(
            foregroundImage: AssetImage(widget.img),
            maxRadius: 20,
          ),
          title: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.price,
            style: const TextStyle(
              fontFamily: 'poppins',
              fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.w400,
            ),
          ),

        ),
      ),
    );
  }
}
