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
                        Navigator.pushNamed(context, '/qna4');
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Questions(
                          title: title,
                          question: question,
                          ans: ans,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomCheckbox(
                          title: 'Standard packaging',
                          icon: Icons.star_border,
                          initialValue: false,
                          onChanged: (bool? value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomCheckbox(
                          title: 'Eco friendly packaging',
                          icon: Icons.mobile_friendly,
                          initialValue: false,
                          onChanged: (bool? value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomCheckbox(
                          title: 'Custom branding/packaging',
                          icon: Icons.branding_watermark,
                          initialValue: false,
                          onChanged: (bool? value) {},
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
                          Navigator.pushNamed(context, '/qna6');
                        },
                        buttonColor: const Color(0xFF4B6F39)),
                    const SizedBox(height: 10),
                    CustomNextButton(
                        text: "Back",
                        onPressed: () {
                          Navigator.pushNamed(context, '/qna4');
                        },
                        buttonColor: const Color(0xFF4B6F39))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}