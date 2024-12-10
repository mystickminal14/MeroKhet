import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/my_cart_controller.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> orderActive = [];
  List<Map<String, dynamic>> orderCompleted = [];
  bool isLoading = true;
String? error;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    listOrder();
  }

  Future<void> listOrder() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final fetchedOrderActive = await MyCartController().getOrder(
        uuid: user!.uid,
        context: context,
        status: 'pending',
      );
      final fetchedOrderCompleted = await MyCartController().getOrder(
        uuid: user.uid,
        context: context,
        status: 'completed',
      );
      setState(() {
        orderActive = fetchedOrderActive;
        orderCompleted = fetchedOrderCompleted;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load orders. Please try again.";

        isLoading = false;
      });
    }
  }


  Future<void> deleteOrder(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final fetchedorderActive = await MyCartController().delete(
        context: context, orderId: id,
      );
      listOrder();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load orders. Please try again.";
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildOrderList(String status) {
    List<Map<String, dynamic>> orders = (status == "Active Orders")
        ? orderActive
        : orderCompleted;

    if (isLoading) {
      return const Loading();
    }

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 70,
              color: Colors.black.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No $status",
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final base64Image = order['image'] ?? '';
        Uint8List? imageBytes;

        if (base64Image.isNotEmpty) {
          try {
            imageBytes = base64Decode(base64Image);
          } catch (e) {
            debugPrint("Error decoding Base64: $e");
          }
        }

        return GestureDetector(
          onTap:status == "Completed Orders" ? (){
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddReview(productId:order['vegetableId']),
            //   ),
            // );
          }:(){},
          child: Card(
          
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: imageBytes != null
                  ? Image.memory(imageBytes, width: 50, height: 50)
                  : Image.asset(
                'assets/Leaf.png',
                width: 50,
                height: 50,
              ),
              title: Text(
                order["vegetableName"] ?? "Unknown",
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                "Rs. ${order['totalPrice'] ?? 'N/A'}",
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Qty: ${order['quantity'] ?? 0}",
                    style: const TextStyle(color: Colors.black),
                  ),
                  if (status == "Active Orders")
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteOrder(order['id']);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Loading(): Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           const HeaderDash(title: 'My Order'),
            if (error != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Active Orders"),
                Tab(text: "Completed"),
              ],
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.green,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList("Active Orders"),
                  _buildOrderList("Completed Orders"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
