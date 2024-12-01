import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String label,hint,helperText;
  final double wid;
  final int line;
  final TextInputType type;
  final ValueChanged<String> onChanged;
  const CustomFormField({super.key, required this.label, required this.hint, required this.helperText, required this.onChanged, required this.wid, required this.type, required this.line});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final border = const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          widget.label,
          style:const TextStyle(
              fontSize: 14, fontFamily: 'poppins', fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5,),
        Container(
          width: MediaQuery.of(context).size.width / widget.wid,
          child: TextField(
            minLines: widget.line,
            maxLines: null,
            keyboardType: widget.type,
            onChanged: widget.onChanged
            ,
            style: const TextStyle(
                fontFamily: 'poppins', fontWeight: FontWeight.w400),


            decoration: InputDecoration(
              hintText: widget.hint,
              helperText:widget.helperText,
              helperStyle: const TextStyle(
                  color: Colors.red,
                  fontFamily: 'poppins',
                  fontStyle: FontStyle.italic),
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              filled: true,

              fillColor: Colors.white,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        )
      ],
    );
  }
}
