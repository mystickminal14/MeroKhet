import 'package:flutter/material.dart';

class CustomCatHead extends StatefulWidget {
  const CustomCatHead({super.key});

  @override
  State<CustomCatHead> createState() => _CustomCatHeadState();
}

class _CustomCatHeadState extends State<CustomCatHead> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Categories",
          style: TextStyle(
              fontFamily: 'poppins-semi'
          ),
        ),IconButton(onPressed: (){Navigator.pushNamed(context, '/categories');}, icon: const Icon(Icons.arrow_forward_ios_rounded,size: 16,))
      ],
    );
  }
}
