import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/GridContainer/individual_category_grid.dart';
import '../../../widgets/DashboardLayouts/header_dash.dart';

class IndividualCategory extends StatefulWidget {
  const IndividualCategory({super.key});

  @override
  State<IndividualCategory> createState() => _IndividualCategoryState();
}

class _IndividualCategoryState extends State<IndividualCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: const Column(
            children: [
              CustomHeaderDash(title: 'Categories', route: '/categories',),
              SizedBox(height: 20),
              Expanded(
                // Ensures the grid takes up remaining space
                child: SingleChildScrollView(
                  // child: IndividualCategoryGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
