import 'package:flutter/material.dart';

import 'package:merokhetapp/screens/consumer/categories.dart';
import 'package:merokhetapp/screens/consumer/consumer_dashboard.dart';
import 'package:merokhetapp/screens/consumer/my_account.dart';
import 'package:merokhetapp/screens/consumer/my_cart.dart';
import 'package:merokhetapp/screens/consumer/my_orders.dart';
import 'package:merokhetapp/services/consumer_controller.dart';

class NavigationFlow extends StatefulWidget {
final int ind;
  const NavigationFlow({super.key, required this.ind});

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
late int myIndex;
  @override
  void initState() {
    super.initState();
    myIndex = widget.ind; // Default index for Home
  }


  final List<Widget> screenList = [
    const Categories(),
    const MyOrders(),
    const ConsumerDashboard(),
    const MyCart(),
    const MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        iconSize: 30,
        type: BottomNavigationBarType.shifting,
        currentIndex: myIndex,
        selectedItemColor: const Color(0xFF4B6F39), // Selected item color
        unselectedItemColor: Colors.black, // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "My Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "My Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "My Account",
          ),
        ],
      ),
      body: screenList[myIndex],
    );
  }
}
