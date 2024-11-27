import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/CustomCheckBox.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';
class Questionnaire3 extends StatefulWidget {
  const Questionnaire3({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return Questionnaire3state();
  }


}
class Questionnaire3state extends State<Questionnaire3>{
  final ans =
      "Please select the type of products you plan to offer. This helps us categorize your business and showcase it to the right customers";
  final title = "Product Focus";
  final qna = "What products will you primarily focus on selling?";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                        title: 'Fresh Vegetables',
                        icon: Icons.grain,
                        initialValue: false,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'Fresh Fruits',
                        icon: Icons.local_florist,
                        initialValue: false,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomCheckbox(
                        title: 'Dairy Products',
                        icon: Icons.local_drink,
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
                        Navigator.pushNamed(context, '/qna4');
                      },
                      buttonColor: const Color(0xFF4B6F39)),
                  const SizedBox(height: 10),
                  CustomNextButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushNamed(context, '/qna2');

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
