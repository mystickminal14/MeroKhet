import 'package:flutter/material.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/auth_validators.dart';
import 'package:merokhetapp/utils/error_dialog.dart';
import 'package:merokhetapp/utils/loaders.dart';
import 'package:merokhetapp/widgets/SocialIcons/facebook_icon.dart';
import 'package:merokhetapp/widgets/SocialIcons/google_icon.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/custom_title.dart';
import 'package:merokhetapp/widgets/logo_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool isLoading = false;
  String pass = '';
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
            hintText: "Enter email or phone number",
            helperText: _isSubmitted ? Validators.validateEmail(email) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400),
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
            hintText: "Password",
            helperText: _isSubmitted ? Validators.validatePassword(pass) : null,
            helperStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'poppins',
                fontStyle: FontStyle.italic),
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
    return isLoading
        ? const Loading()
        : Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Align items with space between
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 20),
                      child: LogoWidget(),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const CustomTitle(
                                  title: "Sign in",
                                  subTitle: "Sign in to your account",
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomGoogleIcon(onPressed: () {}),
                                    const SizedBox(width: 10),
                                    CustomFacebookIcon(onPressed: () {}),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _emailField(),
                                const SizedBox(height: 14),
                                _passwordField(),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/forget_pass');
                                      },
                                      child: const Text(
                                        "Forget Password?",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                CustomButton(
                                  text: "Login",
                                  onPressed: () async {
                                    setState(() {
                                      _isSubmitted = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      dynamic result = await _auth
                                          .logInWithEmailAndPassword(
                                          context, email, pass);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (result != null) {
                                        Navigator.pushNamed(
                                            context, '/wrapper');
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // "New To Platform?" Section at the Bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New To Platform?",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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