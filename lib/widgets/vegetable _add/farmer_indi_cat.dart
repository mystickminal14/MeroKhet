import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/GridContainer/farm_individual_grid.dart';
import 'package:merokhetapp/widgets/GridContainer/individual_category_grid.dart';
import 'package:provider/provider.dart';
import '../../../widgets/DashboardLayouts/header_dash.dart';

class FarmerIndiCat extends StatefulWidget {
  final String? category;
  const FarmerIndiCat({super.key, this.category});

  @override
  State<FarmerIndiCat> createState() => _FarmerIndiCatState();
}

class _FarmerIndiCatState extends State<FarmerIndiCat> {
  bool isLoading = true;
  List<Map<String, dynamic>> categoriesData = [];

  @override
  void initState() {
    super.initState();
    fetchVegetables();
  }

  Future<void> fetchVegetables() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);

      final categoryDatas = await VegService()
          .getVegetablesByCategoryAndFarmerWithDetails(widget.category ?? '',user!.uid);

      if (categoryDatas.isEmpty) {
        print('No vegetables found.');
      } else {
        setState(() {
          categoriesData = categoryDatas;
        });
        print(categoryDatas);
      }
    } catch (e) {
      print("Error fetching vegetables or farmer data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(

            child: SpinKitSquareCircle(
                color: Color(0xff4B6F39), size: 50.0))
            : Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: Column(
            children: [
              CustomHeaderDash(
                title: widget.category ?? 'Category',
                route: '/farm_cat',
              ),
              const SizedBox(height: 20),
              Expanded(
                // Ensures the grid takes up remaining space
                child: categoriesData.isEmpty
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
                    : FarmIndividualGrid(categories: categoriesData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
