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
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'No, I represent a business',
                        icon: Icons.business_center,
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
                        Navigator.pushNamed(context, '/qna3');
                      },
                      buttonColor: const Color(0xFF4B6F39)),
                  const SizedBox(height: 10),
                  CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushNamed(context, '/qna1');
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