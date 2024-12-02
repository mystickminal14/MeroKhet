import 'package:flutter/material.dart';

class DropDownField extends StatefulWidget {
  final String label;
  final int wid;
  final Function(String?) onChanged; // Added onChanged parameter

  const DropDownField({
    super.key,
    required this.label,
    required this.wid,
    required this.onChanged, // Include in constructor
  });

  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: Colors.black,
      style: BorderStyle.solid,
      strokeAlign: BorderSide.strokeAlignCenter,
    ),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  final List<String> items = [
    'Leafy Greens', 'Root Veg', 'Cruciferous', 'Allium', 'Legumes',
    'Fruits Veg', 'Tubers', 'Squash Varieties', 'Herbs and Spicy', 'Mushrooms'
  ];
  String? selectedRegion;

  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: Colors.black,
      style: BorderStyle.solid,
      strokeAlign: BorderSide.strokeAlignCenter,
    ),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width / widget.wid,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: widget.border,
              focusedBorder: widget.border,
            ),
            value: selectedRegion,
            hint: const Text('Select Category'),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRegion = newValue;
              });
              widget.onChanged(newValue); // Call onChanged callback
            },
          ),
        ),
      ],
    );
  }
}
