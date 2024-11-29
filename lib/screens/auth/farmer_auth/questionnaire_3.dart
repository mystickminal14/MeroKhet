import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/CustomCheckBox.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_outlined_back.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

class Questionnaire3 extends StatefulWidget {
  const Questionnaire3({super.key});

  @override
  State<StatefulWidget> createState() {
    return Questionnaire3state();
  }
}

class Questionnaire3state extends State<Questionnaire3> {
  final String ans =
      "Please select the type of products you plan to offer. This helps us categorize your business and showcase it to the right customers";
  final String title = "Product Focus";
  final String qna = "What products will you primarily focus on selling?";

  bool _isSubmitted = false;
  String? selectedAnswer;

  void _updateSelectedAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      _isSubmitted = false; // Reset error message when an option is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve data passed from QnA2
    final Map<String, dynamic>? data =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 15, bottom: 10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  QuestionnaireHeader(
                    onPressed: () {
                      Navigator.pushNamed(context, '/qna2');
                    },
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Questions(
                        title: title,
                        question: qna,
                        ans: ans,
                      ),
                      const SizedBox(height: 25),
                      CustomCheckbox(
                        title: 'Fresh Vegetables',
                        icon: Icons.grain,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Fresh Vegetables");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Fresh Fruits',
                        icon: Icons.local_florist,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Fresh Fruits");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Dairy Products',
                        icon: Icons.local_drink,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Dairy Products");
                        },
                      ),
                      const SizedBox(height: 15),
                      if (_isSubmitted && selectedAnswer == null)
                        const Text(
                          'Please select at least one option.',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  CustomNextButton(
                    text: "Continue",
                    onPressed: () {
                      if (selectedAnswer == null) {
                        setState(() {
                          _isSubmitted = true;
                        });
                      } else {
                        // Combine all data into a single map
                        final Map<String, dynamic> combinedData = {
                          'qna1': data?['qna1'],
                          'qna2': data?['qna2'],
                          'qna3': selectedAnswer,
                        };

                        // Navigate to QnA4 with the combined data
                        Navigator.pushReplacementNamed(
                          context,
                          '/qna4',
                          arguments: combinedData,
                        );
                      }
                    },
                    buttonColor: const Color(0xFF4B6F39),
                  ),
                  const SizedBox(height: 10),
                  CustomOutlinedBack(
                    text: "Back",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/qna2');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
