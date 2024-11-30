import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/navigation/farmer_navigation_flow.dart';
import 'package:merokhetapp/screens/auth/fingerprint_auth.dart';
import 'package:merokhetapp/screens/auth/resetpassword/emailverification.dart';
import 'package:merokhetapp/screens/auth/resetpassword/forgotpassword.dart';
import 'package:merokhetapp/screens/farmers/add_vegetables.dart';
import 'package:merokhetapp/screens/wrapper.dart';
import 'firebase_options.dart';
import 'package:merokhetapp/navigation/navigation_flow.dart';
import 'package:merokhetapp/screens/auth/consumer_registration.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/farmer_registration_page.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/farmer_verification_page.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaie_5.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaire_1.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaire_2.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaire_3.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaire_4.dart';
import 'package:merokhetapp/screens/auth/farmer_auth/questionnaire_6.dart';
import 'package:merokhetapp/screens/auth/login_page.dart';
import 'package:merokhetapp/screens/consumer/IndividualCategory/individual_category.dart';
import 'package:merokhetapp/screens/consumer/categories.dart';
import 'package:merokhetapp/screens/consumer/consumer_dashboard.dart';
import 'package:merokhetapp/screens/flashing_page.dart';
import 'package:merokhetapp/screens/home/home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mero Khet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => const FlashingPage(),
        '/flash': (context) => const FlashingPage(),
        '/login': (context) => const LoginPage(),
        '/navi': (context) => const NavigationFlow(),
        '/email_verify': (context) => const EmailVerification(),
        '/forget_pass': (context) => const ForgetPassword(),

        '/consumer_registration': (context) => const ConsumerRegistration(),
        '/farmer_register': (context) => const FarmerRegistrationPage(),
        '/farmer_verification': (context) => const FarmerVerificationPage(),
        '/qna1': (context) => const Questionnaire1(),
        '/qna2': (context) => const Questionnaire2(),
        '/qna3': (context) => const Questionnaire3(),
        '/qna4': (context) => const Questionnaire4(),
        '/qna5': (context) => const Questionnaire5(),
        '/qna6': (context) => const Questionnaire6(),
        '/home': (context) => const HomePage(),
        '/customer_dashboard': (context) => const ConsumerDashboard(),
        '/categories': (context) => const Categories(),
        '/individual_category': (context) => const IndividualCategory(),

      },
    );
  }
}