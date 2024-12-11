import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';
import 'package:merokhetapp/widgets/GridContainer/category_grid.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/CustomProCard.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';

class Veggies extends StatefulWidget {
  const Veggies({super.key});

  @override
  State<Veggies> createState() => _VeggiesState();
}

class _VeggiesState extends State<Veggies> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> categories = [
    {'text': 'Leafy Greens', 'img': 'assets/Leaf.png'},
    {'text': 'Root Veg', 'img': 'assets/Leaf.png'},
    {'text': 'Cruciferous', 'img': 'assets/Leaf.png'},
    {'text': 'Allium', 'img': 'assets/Leaf.png'},
    {'text': 'Legumes', 'img': 'assets/Leaf.png'},
    {'text': 'Tubers', 'img': 'assets/Leaf.png'},
    {'text': 'Spanish Varieties', 'img': 'assets/Leaf.png'},
    {'text': 'Herbs and Spices', 'img': 'assets/Leaf.png'},
    {'text': 'Mushrooms', 'img': 'assets/Leaf.png'},
    {'text': 'Fruits Veg', 'img': 'assets/Leaf.png'},
  ];

  List<Map<String, String>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // Initially show all categories
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredCategories = categories
          .where((category) => category['text']!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VegHeader(title: 'Categories', route: '/farm_cat'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomerProCard(categories: filteredCategories),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
