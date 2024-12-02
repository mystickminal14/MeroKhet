import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_view_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';

import 'package:provider/provider.dart';

class FarmViewVeg extends StatefulWidget {
  final String vegId;
  const FarmViewVeg({super.key, required this.vegId});

  @override
  State<FarmViewVeg> createState() => _FarmViewVegState();
}

class _FarmViewVegState extends State<FarmViewVeg> {
  bool isLoading = true;
  List<Map<String, dynamic>> vegetables = [];
  Uint8List? imageBytes, imageBytes2;

  @override
  void initState() {
    super.initState();
    fetchVegetables();
  }

  Future<void> fetchVegetables() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      final data = await VegService().getVegetableByFarmerAndVegId(widget.vegId, user!.uid);
      if (data!.isEmpty) return;

      setState(() {
        vegetables = data['vegetable'] != null ? [data] : [];
        isLoading = false;
      });

      final base64Image = vegetables.isNotEmpty ? vegetables[0]['vegetable']['image'] ?? '' : '';
      if (base64Image.isNotEmpty) {
        imageBytes = base64Decode(base64Image);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  final border = const OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: SpinKitSquareCircle(color: Color(0xff4B6F39), size: 50.0))
        : Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            VegHeader(title: vegetables[0]['vegetable']['name'], route: '/farm_cat'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vegetables[0]['vegetable']['name'],
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rs. ${vegetables[0]['vegetable']['price']}',
                                    style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: const Text(
                                      'kg left',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rs. ${vegetables[0]['vegetable']['stock']}',
                                    style: const TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: const Text(
                                      'kg left',
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            vegetables[0]['vegetable']['description'],
                            style: const TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: imageBytes2 != null
                        ? MemoryImage(imageBytes2!)
                        : const AssetImage('assets/F.jpg') as ImageProvider,
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 13),
                  CustomViewButton(
                    text: "Edit",
                    width: MediaQuery.of(context).size.width / 1.3,
                    icon: Icons.shopping_cart,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
