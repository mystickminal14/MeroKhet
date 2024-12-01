import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/custom_file_upload_btn.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/custom_form_field.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/drop_down.dart';
import 'package:merokhetapp/widgets/vegetable%20_add/veg_header.dart';
import 'package:provider/provider.dart';

class AddVegetables extends StatefulWidget {
  const AddVegetables({super.key});

  @override
  State<AddVegetables> createState() => _AddVegetablesState();
}

class _AddVegetablesState extends State<AddVegetables> {
  File? _image;

  bool isLoading = false;
  final picker = ImagePicker();
  String? vegName='';
   String? vegDesc='';
   String? price='';
   String?  stock='';




  String error = '';

  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  Future uploadImg() async {
    final pickedImage2 = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage2 != null) {
      setState(() {
        _image = File(pickedImage2.path);
        error = ''; // Clear previous error if image is selected
      });
    } else {
      setState(() {
        error = "No image selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const VegHeader(title: 'Add Vegetables', route: '/home'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        CustomFileUpload(
                          upload: "Upload the vegetable image",
                          labelText: "Upload valid vegetable image.",
                          onPressed: uploadImg, // Call the upload function here
                          label: "Vegetable image", height: 100,
                        ),
                        CustomFormField(
                          label: 'Vegetable Name',
                          hint: 'vegetable name',
                          helperText: '',
                          onChanged: (value) {
                            setState(() {
                              vegName=value;
                            });
                          },
                          wid: 1,
                          type: TextInputType.text,
                          line: 1,
                        ),
                        const DropDownField(label: 'Select Categories', wid: 1),
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
                                  price=value;
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
                                  stock=value;
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
                              price=value;
                            });
                          },
                          wid: 1,
                          type: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          line: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomFormField(
                          label: 'Description',
                          hint: 'description',
                          helperText: '',
                          onChanged: (value) {
                            setState(() {
                              vegDesc=value;
                            });
                          },
                          wid: 1,
                          type: TextInputType.text,
                          line: 3,
                        ),
                        const SizedBox(height: 2,),
                        CustomButton(text: 'Add', onPressed: (){}),

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
