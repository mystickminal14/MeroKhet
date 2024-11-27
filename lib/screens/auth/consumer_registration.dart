import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/SocialIcons/facebook_icon.dart';
import 'package:merokhetapp/widgets/SocialIcons/google_icon.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/custom_title.dart';


class ConsumerRegistration extends StatefulWidget {
  const ConsumerRegistration({super.key});

  @override
  State<ConsumerRegistration> createState() => _ConsumerRegistrationState();
}

class _ConsumerRegistrationState extends State<ConsumerRegistration> {
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
          "Email or Phone",
          style: TextStyle(
              fontFamily: 'poppins', fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        TextField(
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Email or Phone",
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
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Phone Number",
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
          style: const TextStyle(
              fontFamily: 'poppins', fontSize: 12, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Enter email or phone number",
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
          style: const TextStyle(
              fontFamily: 'poppins', fontWeight: FontWeight.w400),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
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
      body:SingleChildScrollView(child:
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 18, right: 18),
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
                        CustomButton(text: 'Register', onPressed: () {})
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
      ),),
    );
  }
}

