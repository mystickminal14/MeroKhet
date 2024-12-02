import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/screens/consumer/categories.dart';
import 'package:merokhetapp/screens/consumer/consumer_dashboard.dart';
import 'package:merokhetapp/screens/consumer/my_account.dart';
import 'package:merokhetapp/screens/consumer/my_cart.dart';
import 'package:merokhetapp/screens/consumer/my_orders.dart';
import 'package:merokhetapp/screens/farmers/Veggies.dart';
import 'package:merokhetapp/screens/farmers/add_vegetables.dart';
import 'package:merokhetapp/screens/farmers/farmer_account.dart';
import 'package:merokhetapp/screens/farmers/farmer_dashboard.dart';
import 'package:provider/provider.dart';

class FarmerNavigationFlow extends StatefulWidget {
  final int ind;
  const FarmerNavigationFlow({super.key, required this.ind});

  @override
  State<FarmerNavigationFlow> createState() => _FarmerNavigationFlowState();
}

class _FarmerNavigationFlowState extends State<FarmerNavigationFlow> {
  late int myIndex;

  @override
  void initState() {
    super.initState();
    myIndex = widget.ind; // Default index for Home
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    List screenList = [
      const FarmerDashboard(),

      const AddVegetables(),
      const Veggies(),
      const FarmerAccount()
    ];

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
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_sharp),
            label: "Add Veggies",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_sharp),
            label: "My Veggies",
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
