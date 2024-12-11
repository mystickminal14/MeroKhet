import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/my_cart_controller.dart';
import 'package:provider/provider.dart';

import '../../utils/alert.dart';
import '../../utils/loaders.dart';
import 'farm_head.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> with TickerProviderStateMixin {
  late TabController _tabs;
  List<Map<String, dynamic>> pendingOrders = [];
  List<Map<String, dynamic>> acceptedOrders = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    showAllOrders();
  }

  Future<void> showAllOrders() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final showPendingOrder = await MyCartController().getOrder(
        uuid: user!.uid,
        context: context,
        status: 'pending',
      );
      final showAcceptedOrder = await MyCartController().getOrder(
        uuid: user.uid,
        context: context,
        status: 'completed',
      );
      setState(() {
        pendingOrders = showPendingOrder;
        acceptedOrders = showAcceptedOrder;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load orders. Please try again.";
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
      final showPending = await MyCartController().delete(
        context: context, orderId: id,
      );
      ShowAlert.showAlert(
        context,
        "Order cancelled successfully!",
        AlertType.success,
      );
      showAllOrders();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load orders. Please try again.";
        isLoading = false;
      });
    }
  }

  Future<void> updateOrder(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final showPending = await MyCartController().editOrder(
          context: context, orderId: id,status: 'completed'
      );
      ShowAlert.showAlert(
        context,
        "Order Accepted successfully!",
        AlertType.success,
      );
      showAllOrders();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to updaye orders. Please try again.";
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Widget _buildOrderList(String status) {
    List<Map<String, dynamic>> orders = (status == "Active Orders")
        ? pendingOrders
        : acceptedOrders;

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
              size: 64,
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

        return Card(

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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.red),
                        onPressed: () {
                          updateOrder(order['id']);
                        },
                      ),const SizedBox(width:1),
                      IconButton(
                        icon: const Icon(Icons.delete_forever, color: Colors.red),
                        onPressed: () {
                          deleteOrder(order['id']);
                        },
                      ),
                    ],
                  )
              ],
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
            const FarmHead(title: 'My Order'),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            TabBar(
              controller: _tabs,
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
                controller: _tabs,
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
