import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/my_cart_controller.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyCartState();
}

class _MyCartState extends State<MyOrders> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

  Future<void> fetchCart() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final fetchedItems = await MyCartController().getCartItems(
        consumerId: user!.uid,
      );
      setState(() {
        cartItems = fetchedItems;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching cart items: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  int get totalPrice {
    int total = 0;
    for (var item in cartItems) {
      total += int.parse(item['price']) * int.parse(item['quantity']);
    }
    return total;
  }

  void updateQuantity(int index, int change) {
    setState(() {
      int currentQuantity = int.parse(cartItems[index]['quantity']);
      int newQuantity = currentQuantity + change;

      if (newQuantity < 1) {
        newQuantity = 1; // Ensure quantity doesn't go below 1
      }

      cartItems[index]['quantity'] =
          newQuantity.toString(); // Update quantity as string
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: SpinKitSquareCircle(color: Color(0xff4B6F39), size: 50.0),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const HeaderDash(title: 'My Cart'),
                  Expanded(
                    child: cartItems.isEmpty
                        ? const Center(
                            child: Text(
                              'No items in your cart.',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: ListTile(
                                  leading: const Icon(Icons.shopping_cart),
                                  title:
                                      Text(cartItems[index]['vegetableName']),
                                  subtitle:
                                      Text("Rs. ${cartItems[index]['price']}"),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            updateQuantity(index, -1),
                                      ),
                                      Text(cartItems[index]['quantity']),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            updateQuantity(index, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(),
                  Text(
                    "Total: Rs. $totalPrice",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomNextButton(
                    text: 'Checkout',
                    onPressed: () {
                      List<Map<String, dynamic>> checkoutData =
                          cartItems.map((item) {
                        return {
                          'vegetableId': item['vegetableId'],
                          'consumerId':
                              Provider.of<UserModel?>(context, listen: false)!
                                  .uid,
                          'vegetableName': item['vegetableName'],
                          'quantity': item['quantity']
                        };
                      }).toList();
                      Navigator.pushNamed(
                        context,
                        '/checkout',
                        arguments: {
                          'cartItems': checkoutData,
                          'totalPrice': totalPrice,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
