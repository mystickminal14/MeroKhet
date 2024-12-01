import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_view_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/grid_recommended.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/tile.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';

class ViewVegetable extends StatefulWidget {
  const ViewVegetable({super.key});

  @override
  State<ViewVegetable> createState() => _ViewVegetableState();
}

class _ViewVegetableState extends State<ViewVegetable> {
  final border = const OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const VegHeader(title: 'Mushroom', route: '/home'), // Header
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Vegetable Image
                    Container(
                      margin: const EdgeInsets.all(0),
                      child: const Image(
                        image: AssetImage('assets/F.jpg'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 190,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Content Section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vegetable Name
                          const Text(
                            'Button Mushrooms (White Mushrooms)',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Price and Quantity
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Rs. 75',
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: const Text(
                                      'per kg',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Quantity Selector
                              Container(
                                color: Colors.white38,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 1) quantity--;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.exposure_minus_1,
                                        size: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        '$quantity',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      icon: const Icon(Icons.add, size: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Description
                          const Text(
                            'Button mushrooms are one of the most popular and versatile mushrooms. With their mild flavor and firm texture, they can be enjoyed raw in salads or cooked in a variety of dishes, such as stir-fries, soups, and pasta. These mushrooms are packed with essential nutrients like vitamin D, potassium, and antioxidants, making them a healthy addition to your diet.',
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Recommended",
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    // Grid Section
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTiles(
                            img: 'assets/F.jpg',
                            text: 'Apple',
                            price: 'Rs.25 per kg'),
                        CustomTiles(
                            img: 'assets/F.jpg',
                            text: 'Apple',
                            price: 'Rs.25 per kg'),
                      ],
                    ),
                    const SizedBox(height:5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTiles(
                            img: 'assets/F.jpg',
                            text: 'Apple',
                            price: 'Rs.25 per kg'),
                        CustomTiles(
                            img: 'assets/F.jpg',
                            text: 'Apple',
                            price: 'Rs.25 per kg'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    foregroundImage: AssetImage('assets/F.jpg'),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 13),
                  CustomViewButton(
                    text: "Add to Cart",
                    width: MediaQuery.of(context).size.width / 3,
                    icon: Icons.shopping_cart,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  CustomViewButton(
                    text: "Buy Now",
                    icon: Icons.shopping_cart,
                    width: MediaQuery.of(context).size.width / 3,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
