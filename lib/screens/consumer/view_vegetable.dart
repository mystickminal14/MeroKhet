import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/my_cart_controller.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_view_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/grid_recommended.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/tile.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:provider/provider.dart';

class ViewVegetable extends StatefulWidget {
  final String vegId;
  const ViewVegetable({super.key, required this.vegId});

  @override
  State<ViewVegetable> createState() => _ViewVegetableState();
}

class _ViewVegetableState extends State<ViewVegetable> {
  bool isLoading = true;
  List<Map<String, dynamic>> vegetables = [];
  // Member variable to store the ID
  List<Map<String, dynamic>> farmerDatas = [];
  List<Map<String, dynamic>> categoriesData = [];
  Uint8List? imageBytes, imageBytes2;

  @override
  void initState() {
    super.initState();
    fetchVegetables();
  }
  Future<void> fetchVegetables() async {
    try {
      final data = await VegService().getVegetablesById(widget.vegId);
      if (data.isEmpty) {
        print('No vegetables found.');
        return;
      }

      final farmerData =
          await VegService().getFarmerByID(data[0]['vegetable']['farmer_id']);

      final categoryDatas = await VegService()
          .getVegetablesByCategory(data[0]['vegetable']['category']);
      print("categroty: $categoryDatas");
      setState(() {
        vegetables = data;
        farmerDatas = farmerData;
        categoriesData = categoryDatas;
        isLoading = false;
      });

      final base64Image = vegetables.isNotEmpty
          ? vegetables[0]['vegetable']['image'] ?? ''
          : '';
      if (base64Image.isNotEmpty) {
        try {
          imageBytes = base64Decode(base64Image);
        } catch (e) {
          print("Error decoding Base64: $e");
          imageBytes = null;
        }
      }

      final base64Image2 =
          farmerDatas.isNotEmpty ? farmerDatas[0]['farmer']['image'] ?? '' : '';
      if (base64Image2.isNotEmpty) {
        try {
          imageBytes2 = base64Decode(base64Image2);
        } catch (e) {
          print("Error decoding Base64: $e");
          imageBytes2 = null;
        }
      }

    } catch (e) {
      print("Error fetching vegetables or farmer data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  int quantity = 1;
  void addToCart() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final vegetableId = vegetables[0]['vegetable']['id'];
      final vegetableName = vegetables[0]['vegetable']['name'];
      final price = vegetables[0]['vegetable']['price'];

      await MyCartController().addCart(
        context: context,
        consumerId: user?.uid ?? '',
        vegetableId: vegetableId,
        vegetableName: vegetableName,
        price: price,
        quantity: quantity.toString(), status: 'cart',
      );
    } catch (e) {
      print("Error adding to cart: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add to cart')),
      );
    }
  }
  final border = const OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );


  @override
  Widget build(BuildContext context) {
    return isLoading
        ?const Center(

        child: SpinKitSquareCircle(
            color: Color(0xff4B6F39), size: 50.0))
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  VegHeader(
                      title: vegetables[0]['vegetable']['name'],
                      route: '/navi'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Vegetable Image
                          Container(
                            margin: const EdgeInsets.all(0),
                            child: Image.memory(
                              imageBytes!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 190,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Content Section
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Vegetable Name
                                Text(
                                  vegetables[0]['vegetable']['name'],
                                  style: const TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 1),

                                // Price and Quantity
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Price
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Rs. ${vegetables.isNotEmpty ? vegetables[0]['vegetable']['price'] : '0'}',
                                          style: const TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 30,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
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
                                            icon:
                                                const Icon(Icons.add, size: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Description
                                Text(
                                  vegetables[0]['vegetable']['description'],
                                  style: const TextStyle(
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
                          ), Wrap(
                            alignment: WrapAlignment.center,
                            children:categoriesData.take(4).map((category) {
                              return CustomTiles(
                                img: category['image'] ?? 'assets/F.jpg',
                                text: category['name'] ?? 'Unknown',
                                price: 'Rs. ${category['price']} per kg', onPressed: () {
                                final vegetableId = category['id']?.toString();
                                if (vegetableId != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewVegetable(vegId: vegetableId),
                                    ),
                                  );
                                } else {
                                  print("Error: Vegetable ID is null");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Error: Unable to view vegetable details'),
                                    ),
                                  );
                                }
                              },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Buttons
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          foregroundImage: imageBytes2 != null
                              ? MemoryImage(imageBytes2!)
                              : const AssetImage('assets/F.jpg')
                                  as ImageProvider,
                          maxRadius: 20,
                        ),
                        const SizedBox(width: 13),
                        CustomViewButton(
                          text: "Add to Cart",
                          width: MediaQuery.of(context).size.width / 3,
                          icon: Icons.shopping_cart,
                          onPressed:addToCart,
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
