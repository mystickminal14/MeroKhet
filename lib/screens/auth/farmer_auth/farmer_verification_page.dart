import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/custom_file_upload_btn.dart';
import 'package:merokhetapp/widgets/custom_text_field.dart';

class FarmerVerificationPage extends StatefulWidget {
  const FarmerVerificationPage({super.key});

  @override
  State<FarmerVerificationPage> createState() => _FarmerVerificationPageState();
}

class _FarmerVerificationPageState extends State<FarmerVerificationPage> {
  File? _image;
  File? _image2;
  final picker = ImagePicker();
  String error = '', error2 = '';

  // Upload Farmer License Image
  Future uploadLicense() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        error = ''; // Clear previous error if image is selected
      });
    } else {
      setState(() {
        error = "No image selected";
      });
    }
  }

  // Upload Food Safety License Image
  Future uploadFoodLicense() async {
    final pickedImage2 = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage2 != null) {
      setState(() {
        _image2 = File(pickedImage2.path);
        error2 = ''; // Clear previous error if image is selected
      });
    } else {
      setState(() {
        error2 = "No image selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuestionnaireHeader(
                onPressed: () {
                  Navigator.pushNamed(context, 'farmer_register');
                },
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Farm Verification",
                            style: TextStyle(
                              fontFamily: "poppins",
                              fontSize: screenWidth * 0.1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Please provide the necessary business details to complete your registration. This information will help verify your business and ensure compliance with regulations.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'poppins',
                      ),
                    ),
                    const SizedBox(height: 15),
                    const CustomTextField(
                      label: "Farm account name",
                      hintText: "Farm name",
                    ),
                    const SizedBox(height: 15),
                    CustomFileUpload(
                      upload: "Upload farmer license",
                      labelText:
                          "Upload your valid farmer license to verify your farming operations.",
                      onPressed: uploadLicense, // Call the upload function here
                      label: "Farmer License",
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
                            "Farmer License Uploaded successfully!",
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
                    const SizedBox(height: 15),
                    CustomFileUpload(
                      upload: "Upload food safety license",
                      labelText:
                          "Upload your food safety certification to ensure compliance with safety standards.",
                      onPressed:
                          uploadFoodLicense, // Call the upload function here
                      label: "Food Safety License",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_image2 == null)
                          Text(
                            error2,
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
                            "Food Safety License Uploaded successfully!",
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
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomNextButton(
                      text: "Continue",
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      buttonColor: const Color(0xFF4B6F39),
                    ),
                    const SizedBox(height: 10),
                    CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushNamed(context, '/farmer_register');
                      },
                      buttonColor: const Color(0xFF4B6F39),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
