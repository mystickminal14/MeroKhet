import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/auth_validators.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/SocialIcons/facebook_icon.dart';
import 'package:merokhetapp/widgets/SocialIcons/google_icon.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/custom_file_upload_btn.dart';
import 'package:merokhetapp/widgets/custom_title.dart';

import '../../utils/error_dialog.dart';

class ConsumerRegistration extends StatefulWidget {
  const ConsumerRegistration({super.key});

  @override
  State<ConsumerRegistration> createState() => _ConsumerRegistrationState();
}

class _ConsumerRegistrationState extends State<ConsumerRegistration> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  bool isLoading = false;
  String phone = '';
  String email = '';
  String pass = '';
  String error = '';
  String _base64Image = "";
  final picker = ImagePicker();
  File? _image;
  final AuthService _auth = AuthService();
  String? nameErr, passErr, emailErr, phoneErr;
  bool _isSubmitted = false;
  final border = const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.black,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)));

  Widget _nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Fullname",
          style: TextStyle(
              fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            helperText: _isSubmitted ? Validators.validateName(name) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
            hintText: "Full name",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: border,
            focusedBorder: border,
          ),
        )
      ],
    );
  }

  Widget _phone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone Number",
          style: TextStyle(
              fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: (value) {
            setState(() {
              phone = value;
            });
          },
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            helperText: _isSubmitted ? Validators.validatePhone(phone) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
            hintText: "Phone Number",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: border,
            focusedBorder: border,
          ),
        )
      ],
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email or Phone",
          style: TextStyle(
              fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: (value) {
            setState(() {
              email = value;
            });
          },
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),

          decoration: InputDecoration(
            helperText: _isSubmitted ? Validators.validateEmail(email) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
            hintText: "Email",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: border,
            focusedBorder: border,
          ),
        )
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
              fontSize: 14, fontFamily: 'poppins', fontWeight: FontWeight.w400),
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              pass = value;
            });
          },
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            helperText: _isSubmitted ? Validators.validatePassword(pass) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
            hintText: "Password",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            filled: true,
            suffixIcon: const Icon(Icons.visibility_off_rounded),
            fillColor: Colors.white,
            enabledBorder: border,
            focusedBorder: border,
          ),
        )
      ],
    );
  }
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
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 28, left: 18, right: 18),
                        child: QuestionnaireHeader(onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        }),
                      ),

                      //center
                      Column(
                        children: [
                          const CustomTitle(
                            title: 'Join Us',
                            subTitle: 'Sign up with',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomGoogleIcon(onPressed: () {}),
                              const SizedBox(width: 10),
                              CustomFacebookIcon(onPressed: () {}),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 28, right: 28, top: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: _nameField(),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: _phone(),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: _emailField(),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    child: _passwordField(),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  CustomFileUpload(
                                    upload: "Upload your profile image",
                                    labelText:
                                    "Upload  valid profile image",
                                    onPressed:
                                    uploadImg, // Call the upload function here
                                    label: "Profile", height: 40,
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
                                  CustomButton(
                                      text: 'Register',
                                      onPressed: () async {
                                        setState(() {
                                          _isSubmitted = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  context,
                                                  email,
                                                  pass,
                                                  name,
                                                  phone,
                                                  'consumer',  _base64Image);

                                            setState(() {
                                              isLoading = false;
                                            });
                                          Navigator.pushReplacementNamed(
                                              context, '/login');
                                        }
                                      })
                                ],
                              )),
                        ],
                      ),
                      //end of center
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
