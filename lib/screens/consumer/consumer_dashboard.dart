import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/BestDeals/best_deals.dart';
import 'package:merokhetapp/widgets/BestDeals/list_view_best_deals.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/categories_head.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/CustomCategories/custom_categories.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/header_dash.dart';

class ConsumerDashboard extends StatefulWidget {
  const ConsumerDashboard({super.key});

  @override
  State<ConsumerDashboard> createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends State<ConsumerDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              const CustomHeaderDash(title: 'Dashboard'),
              const SizedBox(height: 5),
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
                    const ListViewBestDeals(),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
