import 'package:flutter/material.dart';
import 'package:merokhetapp/services/auth.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_outlined_back.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

import '../../../widgets/QuestionnaireLayouts/CustomCheckBox.dart';

class Questionnaire1 extends StatefulWidget {
  const Questionnaire1({super.key});
  @override
  State<StatefulWidget> createState() {
    return Questionnaire1state();
  }
}

class Questionnaire1state extends State<Questionnaire1> {
  final ans = "";
  final title = "Let’s Begin";
  final qna = "Which of the following best describes your current situation?";


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
                      Navigator.pushNamed(context, '/home');
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
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'I’m new to selling',
                        icon: Icons.add_box_outlined,
                        initialValue: false,
                        onChanged: (bool? value) async {
                          if(value==true){

                              if (value == true) _updateSelectedAnswer("I’m new to selling");

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
                        title: 'I already have a business',
                        icon: Icons.business,
                        initialValue: false,
                        onChanged: (bool? value) async{
                          if (value == true){
                            _updateSelectedAnswer("I already have a business");
                          }else{
                            selectedAnswer=null;
                            _isSubmitted=true;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (_isSubmitted && selectedAnswer == null)
                        const Text(
                          'You must select one option',
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
                          Navigator.pushReplacementNamed(context, '/qna2', arguments: selectedAnswer);
                        }
                      },
                      buttonColor: const Color(0xFF4B6F39)),
                  const SizedBox(height: 10),
                  CustomOutlinedBack(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}