import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/CustomCheckBox.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_outlined_back.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

class Questionnaire4 extends StatefulWidget {
  const Questionnaire4({super.key});

  @override
  State<Questionnaire4> createState() => _Questionnaire4State();
}

class _Questionnaire4State extends State<Questionnaire4> {
  final String title = "Product Focus";
  final String question = "Are your products organic or non-organic?";
  final String ans =
      "How will you package your products? This helps with quality and eco-friendly options";

  bool _isSubmitted = false;
  String? selectedAnswer;

  void _updateSelectedAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      _isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve data passed from QnA3
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
                      Navigator.pushNamed(context, '/qna3');
                    },
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Questions(
                        title: title,
                        question: question,
                        ans: ans,
                      ),
                      const SizedBox(height: 25),
                      CustomCheckbox(
                        title: 'Organic',
                        icon: Icons.nature,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Organic");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Non-Organic',
                        icon: Icons.add_road,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Non-Organic");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Mixed',
                        icon: Icons.mic_external_off,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Mixed");
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
                        final Map<String, dynamic> combinedData = {
                          'qna1': data?['qna1'],
                          'qna2': data?['qna2'],
                          'qna3': data?['qna3'],
                          'qna4': selectedAnswer,
                        };

                        // Navigate to QnA5 with the combined data
                        Navigator.pushReplacementNamed(
                          context,
                          '/qna5',
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
                      Navigator.pushNamed(context, '/qna3');
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
