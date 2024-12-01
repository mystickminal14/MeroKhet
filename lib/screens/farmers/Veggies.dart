import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/CustomProCard.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';


class Veggies extends StatefulWidget {
  const Veggies({super.key});

  @override
  State<Veggies> createState() => _VeggiesState();
}

class _VeggiesState extends State<Veggies> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Widget
            VegHeader(
              title: 'Add Vegetables',
              route: '/home',
            ),

            // Body Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child:CustomProCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
