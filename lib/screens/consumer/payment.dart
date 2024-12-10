import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/my_cart_controller.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String? _selectedTile; // State to track selected tile
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading? const Loading() : Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VegHeader(
              title: 'Payment',
              route: '/checkout',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      const Text(
                        "Payment Methods",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _paymentMethodTile(
                          "Esewa",
                          const FaIcon(FontAwesomeIcons.moneyBill),
                          const Color(0xFF4B6F39)),
                      const SizedBox(height: 20),
                      // Other Section
                      const Text(
                        "Other",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _paymentMethodTile(
                          "Cash on Delivery",
                          const FaIcon(FontAwesomeIcons.dollarSign),
                          const Color(0xFF4B6F39)),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              text: 'Place Order',
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final data = ModalRoute.of(context)
                                    ?.settings
                                    .arguments as Map<String, dynamic>?;
                                final orderedItems =
                                    List<Map<String, dynamic>>.from(
                                        data?['orderDetails'] ?? []);

                                try {
                                  final combinedData = orderedItems.map((item) {
                                    return {
                                      'vegetableId': item['vegetableId'],
                                      'consumerId': Provider.of<UserModel?>(
                                              context,
                                              listen: false)!
                                          .uid,
                                      'vegetableName': item['vegetableName'],
                                      'quantity': item['quantity'],
                                      'farmerId': item['farmerId'],
                                      'cartId': item['cartId'],
                                      'totalPrice': item['totalPrice'],
                                      'delivery': item['totalPrice'],
                                      'image': item['image'],
                                      'method': _selectedTile,
                                      'status':'pending'
                                    };
                                  }).toList();

                                  final fetchedItems =
                                      await MyCartController().orderListOfItems(
                                    context: context,
                                    orderedData: combinedData,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushReplacementNamed(
                                      context, '/my_order');
                                  ShowAlert.showAlert(
                                    context,
                                    "Order Placed Successfully!!",
                                    AlertType.success,
                                  );
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              })),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodTile(String title, Widget icon, Color iconColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTile = title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selectedTile == title
              ? const Color(0xff4B6F39)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: icon,
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
