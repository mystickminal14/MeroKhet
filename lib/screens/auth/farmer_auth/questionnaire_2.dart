import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

import '../../../widgets/QuestionnaireLayouts/CustomCheckBox.dart';

class Questionnaire2 extends StatefulWidget {
  const Questionnaire2({super.key});
  @override
  State<StatefulWidget> createState() {
    return Questionnaire2state();
  }
}

class Questionnaire2state extends State<Questionnaire2> {
  final ans = "";
  final title = "Business";
  final qna = "Are you a farmer or do you represent a business?";

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
    final String? data = ModalRoute.of(context)?.settings.arguments as String?;

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
                      Navigator.pushNamed(context, '/qna1');
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  Column(
                    children: [
                      Questions(
                        title: title,
                        question: qna,
                        ans: ans,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomCheckbox(
                        title: 'Yes, I’m a farmer',
                        icon: Icons.people,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if(value==true){

                            if (value == true) _updateSelectedAnswer("Yes, I’m a farmer");

                          }else{
                            selectedAnswer=null;
                            _isSubmitted=true;

                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'No, I represent a business',
                        icon: Icons.business_center,
                        initialValue: false,
                        onChanged: (bool? value) {
                          if(value==true){

                            if (value == true) _updateSelectedAnswer("No, I represent a business");

                          }else{
                            selectedAnswer=null;
                            _isSubmitted=true;

                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
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
                          Navigator.pushReplacementNamed(context, '/qna3', arguments: {
                            'qna1':data,
                            'qna2':selectedAnswer
                          });
                        }
                      },
                      buttonColor: const Color(0xFF4B6F39)),
                  const SizedBox(height: 10),
                  CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/qna1');
                      },
                      buttonColor: const Color(0xFF4B6F39))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}