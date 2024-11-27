import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';
import '../../../widgets/QuestionnaireLayouts/CustomCheckBox.dart';

class Questionnaire5 extends StatefulWidget {
  const Questionnaire5({super.key});

  @override
  State<Questionnaire5> createState() => _Questionnaire5State();
}

class _Questionnaire5State extends State<Questionnaire5> {
  final String title = "Packaging";
  final String question = "How do you plan to package your products?";
  final String ans =
      "Tell us how you plan to package your products. This information helps in ensuring quality control and attracting eco-conscious customers.";

  bool _isSubmitted = false;
  String? selectedAnswer;

  void _updateSelectedAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      _isSubmitted = false; // Reset error when an option is selected
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      Navigator.pushNamed(context, '/qna4');
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
                        title: 'Standard packaging',
                        icon: Icons.star_border,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Standard packaging");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Eco-friendly packaging',
                        icon: Icons.mobile_friendly,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Eco-friendly packaging");
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Custom branding/packaging',
                        icon: Icons.branding_watermark,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if (value == true) _updateSelectedAnswer("Custom branding/packaging");
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
                          'qna3': data?['qna3'],
                          'qna4': data?['qna4'],
                          'qna5': selectedAnswer,
                        };

                        // Navigate to QnA6 with the combined data
                        Navigator.pushReplacementNamed(
                          context,
                          '/qna6',
                          arguments: combinedData,
                        );
                      }
                    },
                    buttonColor: const Color(0xFF4B6F39),
                  ),
                  const SizedBox(height: 10),
                  CustomNextButton(
                    text: "Back",
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/qna4');
                    },
                    buttonColor: const Color(0xFF4B6F39),
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
