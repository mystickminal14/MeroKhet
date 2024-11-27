import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final TextStyle? helperStyle;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged; // Callback for input changes
  final String? errorText;
  final bool isObscure; // For password fields
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.helperText,
    this.helperStyle,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.isObscure = false,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    );

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: _controller,
            obscureText: widget.isObscure,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              helperText: widget.helperText,
              helperStyle: widget.helperStyle ??
                  const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
              errorText: widget.errorText,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: _isFocused ? Colors.green : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
