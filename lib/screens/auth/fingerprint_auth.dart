import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/custom_next_button.dart';
import 'package:merokhetapp/widgets/QuestionnaireLayouts/questionnaire_header.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({super.key});

  @override
  State<FingerprintAuth> createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<void> checkAuth() async {
    try {
      bool isAvailable = await auth.canCheckBiometrics;

      if (isAvailable) {
        setState(() {
          _isAuthenticating = true;
        });

        bool result = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to proceed',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );

        setState(() {
          _isAuthenticating = false;
        });

        if (result) {
          ShowAlert.showAlert(
            context,
            'Authentication successful!',
            AlertType.success,
          );
        } else {
          ShowAlert.showAlert(
            context,
            'Authentication failed. Please try again.',
            AlertType.error,
          );
        }
      } else {
        ShowAlert.showAlert(
          context,
          'Biometric authentication not available on this device.',
          AlertType.error, // Replace 'warning' with a valid member
        );
      }
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });

      ShowAlert.showAlert(
        context,
        'An error occurred: ${e.toString()}',
        AlertType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuestionnaireHeader(onPressed: () {
              Navigator.pushNamed(context, '/login');
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Fingerprint',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "poppins-bold",
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Authenticate with Biometric fingerprint',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _isAuthenticating ? null : checkAuth,
                  child: Icon(
                    Icons.fingerprint_sharp,
                    size: 250,
                    color: _isAuthenticating ? Colors.grey : Colors.blue,
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomNextButton(
              text: 'Authenticate',
              onPressed: _isAuthenticating ? () {} : checkAuth, // Handle nullability
            ),
          ],
        ),
      ),
    );
  }
}
