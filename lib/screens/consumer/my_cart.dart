import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with TickerProviderStateMixin {
  late TabController _tabController;

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          const HeaderDash(title: 'My Cart'),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Active Order"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList("Active Orders"),
                _buildOrderList("Completed Orders"),
                _buildOrderList("Cancelled Orders"),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.asset(
                'assets/userprofile.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 50);
                },
              ),
              title: Text(orders[index]["name"]),
              subtitle: Text("Rs. ${orders[index]['price']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Qty: ${orders[index]['quantity']}"),
                  if (status == "Active Orders")
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
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
