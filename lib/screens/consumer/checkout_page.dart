import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final screenHeight = MediaQuery.of(context).size.height;
    String delivery = '';
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            const VegHeader(
              title: 'Select Address and Pay',
              route: '/my_cart',
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (e) {
                          setState(() {
                            delivery = e;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Delivery Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      const Divider(),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sub Total", style: TextStyle(fontSize: 16)),
                            Text("\u20B91035", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery", style: TextStyle(fontSize: 16)),
                            Text("\u20B90", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\u20B91035",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ListTile(
                        title: Text(
                          "Add More Items to Cart",
                          style: TextStyle(color: Colors.red.shade600),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.red,
                          size: 16,
                        ),
                        onTap: () {
                          // Add functionality to navigate back to shopping
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              child: CustomButton(
                text: 'Proceed to Payment',
                onPressed: () {
                  final List<Map<String, dynamic>> cartItems =
                      List<Map<String, dynamic>>.from(data?['cartItems']);
                  final int totalPrice = int.tryParse(data!['totalPrice'].toString()) ?? 0;
                  final cartData = cartItems.map((item) {
                    final price =
                        int.tryParse(item['price']?.toString() ?? '0') ?? 0;
                    final quantity =
                        int.tryParse(item['quantity']?.toString() ?? '0') ?? 0;
                    final indTotal = price * quantity;

                    return {
                      'vegetableId': item['vegetableId'],
                      'cartId': item['cartId'],
                      'consumerId':
                          Provider.of<UserModel?>(context, listen: false)!.uid,
                      'vegetableName': item['vegetableName'],
                      'quantity': item['quantity'],
                      'farmerId': item['farmerId'],
                      'image': item['image'],
                      'totalPrice':item['totalPrice'],
                      'delivery': delivery
                    };
                  }).toList();

                  Navigator.pushReplacementNamed(
                    context,
                    '/payment',
                    arguments: {
                      'orderDetails': cartData,
                      'totalPrice': totalPrice,
                      'delivery': delivery,
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
