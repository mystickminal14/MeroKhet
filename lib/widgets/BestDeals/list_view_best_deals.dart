import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/BestDeals/best_deals.dart';

class ListViewBestDeals extends StatefulWidget {
  const ListViewBestDeals({super.key});

  @override
  State<ListViewBestDeals> createState() => _ListViewBestDealsState();
}

class _ListViewBestDealsState extends State<ListViewBestDeals> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(0),
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CustomCard(),
          SizedBox(width: 10),
          CustomCard(),
          SizedBox(width: 10),
          CustomCard(),
        ],
      ),
    );
  }
}
