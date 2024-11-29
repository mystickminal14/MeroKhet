
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", ""); // Remove the # symbol if present
    return Color(int.parse("FF$hex", radix: 16)); // Convert to Color
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/mklogo.png',width: 150,height: 200,),
                      const Text('Forgot Password',style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,fontFamily:'poppins'),textAlign: TextAlign.center,),

                      Text('Enter the email associated with your account and we’ll send an email instructions to reset your password',style: TextStyle(fontFamily: 'poppins',),textAlign:TextAlign.center,),
                      SizedBox(height: 40),
                      const Text('Email',style: TextStyle(fontSize: 15,fontFamily:'poppins'),),
                      SizedBox(height:10),
                      const TextField(decoration: InputDecoration(
                        hintText: "Email Address",
                        labelStyle: TextStyle(color: Colors.green),// Placeholder text
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2.0),
                        ), // Adds a border around the TextField
                      ),)]

                )

            ),
            Container(
              child: Column(
                children: [
                  // Search Email Button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: hexToColor("#4B6F39"), // Button background color
                      foregroundColor: Colors.white, // Text color
                      minimumSize: Size(500, 50), // Increase button size (width, height)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Decrease curve radius
                      ),
                    ),
                    child: const Text('Search Email'),
                  ),
                  SizedBox(height: 10), // Add spacing between the buttons

                  // Back Button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.black, // Text color
                      side: BorderSide(color: Colors.black, width: 1), // Border color and width
                      minimumSize: Size(500, 50), // Increase button size (width, height)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Decrease curve radius
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    ) ;
  }
}
