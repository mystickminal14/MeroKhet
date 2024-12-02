import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyCartState();
}

class _MyCartState extends State<MyOrders> {
  // Example cart data
  List<Map<String, dynamic>> cartItems = [
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 185, "quantity": 1},
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 185, "quantity": 1},
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 185, "quantity": 1},
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 185, "quantity": 1},
    {"name": "Cremini Mushrooms (Baby Bella)", "price": 185, "quantity": 1},
  ];

  int get totalPrice {
    int total = 0;
    for (var item in cartItems) {
      total += (item['price'] as int) *
          (item['quantity'] as int); // Explicitly cast to int
    }
    return total;
  }

  // Method to update quantity of item
  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]['quantity'] += change;
      if (cartItems[index]['quantity'] < 1) {
        cartItems[index]['quantity'] = 1; // Ensure quantity doesn't go below 1
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Cart')),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/Leaf.png', fit: BoxFit.cover),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context); // Goes back to the previous screen
            },
          ),
        ],
        elevation: 0, // Replace with your logo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text(cartItems[index]['name']),
                      subtitle: Text("Rs. ${cartItems[index]['price']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => updateQuantity(index, -1),
                          ),
                          Text(cartItems[index]['quantity'].toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => updateQuantity(index, 1),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Checkout page
                Navigator.pushNamed(context, '/checkout');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
                minimumSize:
                const Size(double.infinity, 50), // White text color
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12), // Optional: Rounded corners
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16, // You can adjust the text size as needed
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}