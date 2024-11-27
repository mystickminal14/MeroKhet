import 'package:flutter/material.dart';
import 'package:merokhetapp/utils/auth_validators.dart';
import 'package:merokhetapp/utils/error_dialog.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/SocialIcons/facebook_icon.dart';
import 'package:merokhetapp/widgets/SocialIcons/google_icon.dart';


import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_title.dart';

class FarmerRegistrationPage extends StatefulWidget {
  const FarmerRegistrationPage({super.key});

  @override
  State<FarmerRegistrationPage> createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String email = '';
  String pass = '';

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
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child:SingleChildScrollView(
        child:Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28, left: 18, right: 18),
                  child: QuestionnaireHeader(onPressed: () {
                    Navigator.pushNamed(context, '/qna6');
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
                        padding:
                        const EdgeInsets.only(left: 28, right: 28, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            CustomButton(text: 'Register', onPressed: ()async{
                              setState(() {
                                _isSubmitted = true;
                              });


                              if (_formKey.currentState!.validate()) {

                                final Map<String, dynamic>? data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

                                // Prepare combined data with form input values
                                final Map<String, dynamic> combinedData = {
                                  ...data ?? {},
                                  'name': name,
                                  'phone': phone,
                                  'email': email,
                                  'password': pass,
                                  'role': "farmer",
                                };


                                await Navigator.pushReplacementNamed(
                                  context,
                                  '/farmer_verification',
                                  arguments: combinedData,
                                );
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
    )
    ));
  }
}
