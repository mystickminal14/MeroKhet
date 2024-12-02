import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_view_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/grid_recommended.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/tile.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';

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
  List<Map<String, dynamic>> Categories = [];


  @override
  void initState() {
    super.initState();
    fetchVegetables();
  }

  Future<void> fetchVegetables() async {
    try {

      final data = await VegService().getVegetablesById(widget.vegId);
      // final farmerData=await VegService().getFarmerByID(data[0]['farmer_id']);
      // final cate = await VegService().getVegetablesByCategory(data[0]['category']);
      // print(farmerData);
      // print(cate);


      setState(() {
        vegetables = data;
        // farmerDatas= farmerData;
        // Categories=cate;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching vegetables: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  final border = const OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  int quantity = 1;

  @override
  Widget build(BuildContext context) {

    return isLoading ?  vegetables.isEmpty // Check if data is empty
        ? const Center(
      child: Text(
        "No data available",
        style: TextStyle(
          fontFamily: 'poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
        : Container(
        width: double.infinity,
        padding: null,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SpinKitSquareCircle(color: Color(0xff4B6F39), size: 50.0),
          ],
        )) : Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             VegHeader(title: vegetables[0]['name'], route: '/home'), // Header
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
                           Text(
                           vegetables[0]['name'],
                            style: const TextStyle(
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
                                   Text(
                                     'Rs. ${vegetables[0]['price']}',
                                    style:const  TextStyle(
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
                           Text(
                          vegetables[0]['description']  ,
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
