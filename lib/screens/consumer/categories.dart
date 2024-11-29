import 'package:flutter/material.dart';
import '../../widgets/DashboardLayouts/header_dash.dart';
import '../../widgets/GridContainer/category_grid.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderDash(title: 'Categories', route: '/customer_dashboard',),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: CategoryGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
