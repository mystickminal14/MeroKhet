import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/DashboardLayouts/dash_header.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';

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
    print(data);
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VegHeader(
                title: 'Select Address and Pay',
                route: '/navi',
              ),
              const Text(
                "Delivery",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Delivery Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Coupon Code Section
              const Divider(),
              // Price Details
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sub Total", style: TextStyle(fontSize: 16)),
                    Text("₹1035", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery", style: TextStyle(fontSize: 16)),
                    Text("₹0", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹1035",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Add More Items to Cart
              ListTile(
                title: Text(
                  "Add More Items to Cart",
                  style: TextStyle(color: Colors.red.shade600),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.red, size: 16),
                onTap: () {},
              ),
              SizedBox(height: screenHeight * 0.03),
              // Proceed to Payment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Proceed to Payment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
