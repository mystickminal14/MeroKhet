import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/products.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/custom_file_upload_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_form_field.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/drop_down.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class EditVegetables extends StatefulWidget {
  const EditVegetables({super.key});

  @override
  State<EditVegetables> createState() => _EditVegetablesState();
}

class _EditVegetablesState extends State<EditVegetables> {
  File? _image;
  bool isLoading = false;
  final picker = ImagePicker();
  String vegName = '';
  String vegDesc = '';
  String price = '';
  String stock = '';
  String discount = '';
  String? category;
  String total = '';
  String discountPrice = '';
  String error = '';
  String _base64Image = "";

  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  Future uploadImg() async {
    final XFile? pickedImage2 =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage2 != null) {
      final bytes = await pickedImage2.readAsBytes();
      setState(() {
        _image = File(pickedImage2.path);
        _base64Image = base64Encode(bytes);
        error = ''; // Clear any previous errors
      });
    } else {
      setState(() {
        error = "No image selected";
      });
    }
  }

  void calculateTotals() {
    double? priceValue = double.tryParse(price);
    double? stockValue = double.tryParse(stock);
    double? discountValue = double.tryParse(discount);

    if (priceValue != null && stockValue != null) {
      double calculatedTotal = priceValue * stockValue;
      setState(() {
        total = calculatedTotal.toStringAsFixed(2);
        if (discountValue != null) {
          double calculatedDiscountPrice =
              calculatedTotal - (calculatedTotal * discountValue / 100);
          discountPrice = calculatedDiscountPrice.toStringAsFixed(2);
        } else {
          discountPrice = total;
        }
      });
    } else {
      setState(() {
        total = '0.00';
        discountPrice = '0.00';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserModel?>(context);

    return isLoading
        ? const Loading()
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(0),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const VegHeader(title: 'Edit Vegetables', route: '/home'),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              CustomFileUpload(
                                upload: "Upload the vegetable image",
                                labelText: "Upload valid vegetable image.",
                                onPressed: uploadImg,
                                label: "Vegetable image",
                                height: 100,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (_image == null)
                                    Text(
                                      error,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    )
                                  else
                                    const Text(
                                      "Vegetable Image Uploaded successfully!",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                ],
                              ),
                              CustomFormField(
                                label: 'Vegetable Name',
                                hint: 'vegetable name',
                                helperText: '',
                                onChanged: (value) {
                                  setState(() {
                                    vegName = value;
                                  });
                                },
                                wid: 1,
                                type: TextInputType.text,
                                line: 1,
                              ),
                              DropDownField(
                                label: 'Select Categories',
                                wid: 1,
                                onChanged: (value) {
                                  setState(() {
                                    category = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  CustomFormField(
                                    label: 'Price per kg',
                                    hint: 'Add price per kg',
                                    helperText: '',
                                    onChanged: (value) {
                                      setState(() {
                                        price = value;
                                        calculateTotals();
                                      });
                                    },
                                    wid: 2.3,
                                    type: const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    line: 1,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomFormField(
                                    label: 'Stock',
                                    hint: 'Stock in kg',
                                    helperText: '',
                                    onChanged: (value) {
                                      setState(() {
                                        stock = value;
                                        calculateTotals();
                                      });
                                    },
                                    wid: 2.3,
                                    type: const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    line: 1,
                                  ),
                                ],
                              ),
                              CustomFormField(
                                label: 'Discount percentage',
                                hint: 'Discount Price',
                                helperText: '',
                                onChanged: (value) {
                                  setState(() {
                                    calculateTotals();
                                  });
                                },
                                wid: 1,
                                type: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                line: 1,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              CustomFormField(
                                label: 'Description',
                                hint: 'description',
                                helperText: '',
                                onChanged: (value) {
                                  setState(() {
                                    vegDesc = value;
                                  });
                                },
                                wid: 1,
                                type: TextInputType.text,
                                line: 3,
                              ),
                              const SizedBox(height: 2),
                              CustomButton(
                                  text: 'Edit', onPressed: () async {}),
                              const SizedBox(height: 20),
                              CustomButton(
                                  text: 'Delete', onPressed: () async {}),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
