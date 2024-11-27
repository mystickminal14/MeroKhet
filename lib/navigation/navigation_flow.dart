import 'package:flutter/material.dart';
import 'package:merokhetapp/screens/consumer/categories.dart';
import 'package:merokhetapp/screens/consumer/consumer_dashboard.dart';
import 'package:merokhetapp/screens/consumer/my_account.dart';
import 'package:merokhetapp/screens/consumer/my_cart.dart';
import 'package:merokhetapp/screens/consumer/my_orders.dart';

class NavigationFlow extends StatefulWidget {
  const NavigationFlow({super.key});

  @override
  State<NavigationFlow> createState() => _NavigationFlowState();
}

class _NavigationFlowState extends State<NavigationFlow> {
  int myIndex = 2;
  List screenList = [
    const Categories(),
    const MyCart(),
    const ConsumerDashboard(),
    const MyOrders(),
    const MyAccount()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        iconSize: 30,
        type: BottomNavigationBarType.shifting,
        currentIndex: myIndex,
        // Background color
        selectedItemColor: const Color(0xFF4B6F39), // Selected item color
        unselectedItemColor: Colors.black, // Unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "My Order",
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
