import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

import '../../../widgets/QuestionnaireLayouts/CustomCheckBox.dart';

class Questionnaire6 extends StatefulWidget {
  const Questionnaire6({super.key});
  @override
  State<Questionnaire6> createState() => _Questionnaire6State();
}

class _Questionnaire6State extends State<Questionnaire6> {
  final String title = "Region of Sale";
  final String question =
      "Select the region where you will focus on selling your products to connect with local customers.";
  final String ans = "";
  final List<String> items = ['Kathmandu', 'Pokhara', 'Bhaktapur', 'Lalitpur'];

  // Default selected value
  String? selectedItem;

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
                        Navigator.pushNamed(context, '/qna5');
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
                        DropdownButton<String>(
                          menuWidth: double.maxFinite,
                          value: selectedItem,
                          hint: const Text('Select an option'),
                          items: items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedItem = newValue;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment
                              .centerLeft, // You can choose other alignment options here
                          child: Text(
                            "Will you deliver your own products?",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomCheckbox(
                          title: 'Yes',
                          icon: Icons.signal_wifi_4_bar_outlined,
                          initialValue: false,
                          onChanged: (bool? value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomCheckbox(
                          title: 'No',
                          icon: Icons.signal_wifi_4_bar_lock,
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
                          Navigator.pushNamed(
                              context, '/farmer_register');
                        },
                        buttonColor: const Color(0xFF4B6F39)),
                    const SizedBox(height: 10),
                    CustomNextButton(
                        text: "Back",
                        onPressed: () {
                          Navigator.pushNamed(context, '/qna5');
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