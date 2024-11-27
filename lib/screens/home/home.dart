import 'package:flutter/material.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';
import 'package:merokhetapp/widgets/custom_button.dart';
import 'package:merokhetapp/widgets/icon_row_text.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            padding:
                const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 1),
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               QuestionnaireHeader(onPressed: (){
                 Navigator.pushNamed(context,'/login');
               }),
                Container(
                  margin: const EdgeInsets.only(
                    top: 0,
                    left: 0,
                  ), // Add margin for spacing
                  child: const Image(
                    image: AssetImage('assets/Leaf.png'),
                    fit: BoxFit.cover,
                    width: 280,
                    height: 170,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Locally Produced, Locally  ",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Sourced ",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Empowering farmers, delighting consumers, one fresh, local harvest at a time.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Column(
                  children: [
                    CustomRow(
                        icon: Icons.car_rental,
                        text: "Get started with selling locally"),
                    SizedBox(
                      height: 5,
                    ),
                    CustomRow(
                        icon: Icons.people,
                        text: "Sell and grow your audience"),
                  ],
                ),
                Column(
                  children: [
                    CustomButton(
                      text: "Join the Marketplace",
                      onPressed: () {
                        Navigator.pushNamed(context, '/qna1');
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      text: "Get Started with Shopping",
                      onPressed: () {
                        Navigator.pushNamed(context, '/consumer_registration');
                      },
                    ),
                  ],
                )
              ],
            ))));
  }
}
