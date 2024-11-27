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
  String? selectedRegion,ansBO;
  bool? willDeliver;
  bool _isSubmitted = false;

  void _updateDeliveryOption(bool value) {
    setState(() {
      willDeliver = value;
      ansBO='Yes';
      _isSubmitted = false; // Reset validation on selection
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
                      Navigator.pushNamed(context, '/qna5');
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
                      const SizedBox(height: 15),
                      DropdownButton<String>(
                        value: selectedRegion,
                        hint: const Text('Select an option'),
                        items: items.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedRegion = newValue;
                            _isSubmitted = false; // Reset validation
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Will you deliver your own products?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'Yes',
                        icon: Icons.check,
                        initialValue: willDeliver == true,
                        onChanged: (bool? value) {
                          if (value == true) _updateDeliveryOption(true);
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCheckbox(
                        title: 'No',
                        icon: Icons.close,
                        initialValue: willDeliver == false,
                        onChanged: (bool? value) {
                          if (value == true) _updateDeliveryOption(false);
                        },
                      ),
                      const SizedBox(height: 15),
                      if (_isSubmitted && (selectedRegion == null || willDeliver == null))
                        const Text(
                          'Please select a region and delivery option.',
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
                      if (selectedRegion == null || willDeliver == null) {
                        setState(() {
                          _isSubmitted = true;
                        });
                      } else {

                        final Map<String, dynamic> combinedData = {
                          'qna1': data?['qna1'],
                          'qna2': data?['qna2'],
                          'qna3': data?['qna3'],
                          'qna4': data?['qna4'],
                          'qna5': data?['qna5'],
                          'qna6_region': selectedRegion,
                          'qna6_delivery': ansBO,
                        };

                        // Navigate to the farmer registration step
                        Navigator.pushReplacementNamed(
                          context,
                          '/farmer_register',
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
                      Navigator.pushReplacementNamed(context, '/qna5');
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
