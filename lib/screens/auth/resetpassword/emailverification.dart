
import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionnaireHeader(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const Center(child: Text('Verification',style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,fontFamily:'poppins'),textAlign: TextAlign.center,)),
                  const SizedBox(height:10),
                  const Text('Enter the 5-digit code you received in your email.',style: TextStyle(fontFamily: 'poppins',),textAlign:TextAlign.center,),

                  const SizedBox(height:20),
                  const TextField(decoration: InputDecoration(
                    hintText: "Verification Code",
                    labelStyle: TextStyle(color: Colors.green),// Placeholder text
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ), // Adds a border around the TextField
                  ),)]

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
                      minimumSize: const Size(500, 50), // Increase button size (width, height)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Decrease curve radius
                      ),
                    ),
                    child: const Text('Verify'),
                  ),
                  const SizedBox(height: 10), // Add spacing between the buttons

                  // Back Button
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      foregroundColor: Colors.black, // Text color
                      side: const BorderSide(color: Colors.black, width: 1), // Border color and width
                      minimumSize: const Size(500, 50), // Increase button size (width, height)
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