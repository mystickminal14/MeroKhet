import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with TickerProviderStateMixin {
  // Create a TabController
  late TabController _tabController;

  // Sample lists for different order statuses
  List<Map<String, dynamic>> activeOrders = [
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 565, "quantity": 4},
    {"name": "Tomatoes", "price": 150, "quantity": 2},
  ];

  List<Map<String, dynamic>> completedOrders = [
    {"name": "Potatoes", "price": 200, "quantity": 3},
    {"name": "Onions", "price": 120, "quantity": 1},
  ];

  List<Map<String, dynamic>> cancelledOrders = [
    {"name": "Garlic", "price": 100, "quantity": 5},
    {"name": "Spinach", "price": 80, "quantity": 1},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to delete an item from the list of orders
  void deleteOrder(String status, int index) {
    setState(() {
      if (status == "Active Orders") {
        activeOrders.removeAt(index);
      } else if (status == "Completed Orders") {
        completedOrders.removeAt(index);
      } else if (status == "Cancelled Orders") {
        cancelledOrders.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/Leaf.png',
              fit: BoxFit.cover), // Replace with your logo
        ),
        automaticallyImplyLeading: false, // Remove the back button
        title: const Center(child: Text("My Orders")),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context); // Goes back to the previous screen
            },
          ),
        ],
        elevation: 0, // Removes shadow below the app bar
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Active Order"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Order Tab
          _buildOrderList("Active Orders"),
          // Completed Tab
          _buildOrderList("Completed Orders"),
          // Cancelled Tab
          _buildOrderList("Cancelled Orders"),
        ],
      ),
    );
  }

  // Reusable method to build the order list for each tab
  Widget _buildOrderList(String status) {
    List<Map<String, dynamic>> orders = [];
    if (status == "Active Orders") {
      orders = activeOrders;
    } else if (status == "Completed Orders") {
      orders = completedOrders;
    } else if (status == "Cancelled Orders") {
      orders = cancelledOrders;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: orders.length, // Dynamic list based on orders count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.asset(
                  'assets/userprofile.jpg'), // Replace with your image
              title: Text(orders[index]["name"]),
              subtitle: Text("Rs. ${orders[index]['price']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Qty: ${orders[index]['quantity']}"),
                  // Only show delete button for active orders
                  if (status == "Active Orders")
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Delete the item based on the tab's status
                        deleteOrder(status, index);
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
