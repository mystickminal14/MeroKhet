import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/GridContainer/individual_category_grid.dart';
import '../../../widgets/DashboardLayouts/header_dash.dart';

class IndividualCategory extends StatefulWidget {
  final String? category;
  const IndividualCategory({super.key, this.category});

  @override
  State<IndividualCategory> createState() => _IndividualCategoryState();
}

class _IndividualCategoryState extends State<IndividualCategory> {
  bool isLoading = true;
  List<Map<String, dynamic>> categoriesData = [];
  List<Map<String, dynamic>> filteredData = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchVegetables();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> fetchVegetables() async {
    try {
      final categoryDatas = await VegService()
          .getAllVegetablesCatWithFarmers(widget.category ?? '');

      if (categoryDatas.isEmpty) {
        print('No vegetables found.');
      } else {
        setState(() {
          categoriesData = categoryDatas;
          filteredData = categoryDatas; // Initially show all data
        });
      }
    } catch (e) {
      print("Error fetching vegetables or farmer data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredData = categoriesData
            .where((item) => item['vegetable']['name']
            .toString()
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: SpinKitSquareCircle(
              color: Color(0xff4B6F39), size: 50.0),
        )
            : Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: Column(
            children: [
              CustomHeaderDash(
                title: widget.category ?? 'Category',
                route: '/cate',
              ),
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
                        borderRadius:
                        BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.8,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                // Ensures the grid takes up remaining space
                child: filteredData.isEmpty
                    ? const Center(
                  child: Text(
                    "No vegetables found.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
                    : IndividualCategoryGrid(categories: filteredData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
