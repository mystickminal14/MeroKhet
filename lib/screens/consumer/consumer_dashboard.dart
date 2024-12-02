import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/BestDeals/best_deals.dart';
import 'package:merokhetapp/widgets/BestDeals/list_view_best_deals.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/categories_head.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/custom_categories.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/for_you.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';

class ConsumerDashboard extends StatefulWidget {
  const ConsumerDashboard({super.key});

  @override
  State<ConsumerDashboard> createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends State<ConsumerDashboard> {
  bool isLoading = true;
  List<Map<String, dynamic>> vegetables = [];
  @override
  void initState() {
    super.initState();
    fetchVegetables();
  }
  Future<void> fetchVegetables() async {
    try {
      // Fetch data using the updated method
      final data = await VegService().getAllVegetablesWithFarmers();
      setState(() {
        vegetables = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching vegetables: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            
            children: [
              const HeaderDash(title: 'Dashboard'),
             isLoading?  Container(
                 width: double.infinity,
                 padding: null,
                 child: const Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     SpinKitSquareCircle(color: Color(0xff4B6F39), size: 50.0),
                   ],
                 ))  :Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: [

                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8),
                       child: Column(
                         children: [
                           Container(
                             height: 130,
                             color: Colors.black,
                           ),
                           const SizedBox(height: 15),
                           const CustomCatHead(),
                           const SizedBox(height: 15),
                           const CustomCategories(),
                           const SizedBox(height: 15),
                           const Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Text(
                                 "Best Deals",
                                 style: TextStyle(fontFamily: 'poppins-semi'),
                               )
                             ],
                           ),
                           ListViewBestDeals(bestDeals: vegetables,),
                           const SizedBox(height: 15),
                           const Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Text(
                                 "For You",
                                 style: TextStyle(fontFamily: 'poppins-semi'),
                               )
                             ],
                           ),
                           const SizedBox(height: 10),
                           SizedBox(
                             height: MediaQuery.of(context).size.height * 0.5,
                             child: ForYou(vegetables: vegetables,),
                           ),
                         ],
                       ),
                     )
                   ],
                 ),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
