import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/CustomCheckBox.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questions.dart';

 class Questionnaire4 extends StatefulWidget {
   const Questionnaire4({super.key});
   @override
   State<Questionnaire4> createState() => _Questionnaire4State();
 }

 class _Questionnaire4State extends State<Questionnaire4> {
   final String title="Product Focus";
   final String question="Are your products organic or non-organic?";
   final String ans="How will you package your products? This helps with quality and eco-friendly options";

   @override
   Widget build(BuildContext context) {
     return   Scaffold(
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
                           title: 'Organic',
                           icon: Icons.nature,
                           initialValue: false,
                           onChanged: (bool? value) {},
                         ),
                         const SizedBox(
                           height: 15,
                         ),
                         CustomCheckbox(
                           title: 'Non-Organic',
                           icon: Icons.add_road,
                           initialValue: false,
                           onChanged: (bool? value) {},
                         ),
                         const SizedBox(
                           height: 15,
                         ),
                         CustomCheckbox(
                           title: 'Mixed',
                           icon: Icons.mic_external_off,
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
                           Navigator.pushNamed(context, '/qna5');

                         },
                         buttonColor: const Color(0xFF4B6F39)),
                     const SizedBox(height: 10),
                     CustomNextButton(
                         text: "Back",
                         onPressed: () {
                           Navigator.pushNamed(context, '/qna3');

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
