import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
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
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'I already have a business',
                        icon: Icons.business,
                        initialValue: false,
                        onChanged: (bool? value) {},
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
                        Navigator.pushNamed(context, '/qna2');
                      },
                      buttonColor: const Color(0xFF4B6F39)),
                  const SizedBox(height: 10),
                  CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
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