import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/auth_validators.dart';
import 'package:merokhetapp/utils/error_dialog.dart';
import 'package:merokhetapp/utils/loaders.dart';
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
  bool isLoading=false;
  final picker = ImagePicker();
  final AuthService _auth = AuthService();
  String _base64Image = "";

  File? _image3;
  String error = '', error2 = '', farmName = '';
  String? nameErr = '';
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
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
  Future uploadImg() async {
    final XFile? pickedImage2 =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage2 != null) {
      final bytes = await pickedImage2.readAsBytes();
      setState(() {
        _image3 = File(pickedImage2.path);
        _base64Image = base64Encode(bytes);
        error = ''; // Clear any previous errors
      });
    } else {
      setState(() {
        error = "No image selected";
      });
    }
  }

  void _onRegister() async {
    setState(() {
      _isSubmitted = true;
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading=true;
      });
      final Map<String, dynamic>? data =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (data?['email'] == null) {
        setState(() {
          isLoading=false;
        });
        ErrorDialog.showErrorDialog(
            context, "Missing em required information.");
        return;
      }

      if (data?['qna6_region'] == null) {
        ErrorDialog.showErrorDialog(context, "Missing required information.");
        return;
      }
      if (_formKey.currentState!.validate()) {
        dynamic result = await _auth.registerWithEmailAndPassword(
          context,
          data?['email'],
          data?['password'],
          data?['name'],
          data?['phone'],
          data?['role'],
          _base64Image,
          farmAccountName: farmName,
          license: _image?.path,
          foodSafety: _image2?.path,
          situation: data?['qna1'],
          business: data?['qna2'],
          productFocused: data?['qna3'],
          productNature: data?['qna4'],
          package: data?['qna5'],
          region: data?['qna6_region'],
          delivery: data?['qna6_delivery'],
        );

          setState(() {
            isLoading = false;
          });
        Navigator.pushReplacementNamed(context, '/login');}

    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return isLoading? const Loading(): Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuestionnaireHeader(
                  onPressed: () {
                    Navigator.pushNamed(context, 'farmer_register');
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
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
                        CustomTextField(
                          label: 'Farm Account Name',
                          hintText: 'Farm Name',
                          helperText: _isSubmitted
                              ? Validators.validateFarmName(farmName)
                              : null,
                          helperStyle: const TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                          onChanged: (value) {
                            setState(() {
                              farmName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomFileUpload(
                          upload: "Upload farmer license",
                          labelText:
                              "Upload your valid farmer license to verify your farming operations.",
                          onPressed:
                              uploadLicense, // Call the upload function here
                          label: "Farmer License", height: 40,
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
                          upload: "Upload farm image",
                          labelText:
                          "Upload your valid farm image",
                          onPressed:
                          uploadImg, // Call the upload function here
                          label: "Farm Image", height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (_image3 == null)
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
                          label: "Food Safety License", height: 40,
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
                                style:  TextStyle(
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
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    CustomNextButton(
                      text: "Register",
                      onPressed: _onRegister,
                      buttonColor: const Color(0xFF4B6F39),
                    ),
                    const SizedBox(height: 10),
                    CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/farmer_register');
                      },
                      buttonColor: const Color(0xFF4B6F39),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
