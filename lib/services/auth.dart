import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/model/consumer.model.dart';
import 'package:merokhetapp/model/farmer_detail.dart';
import 'package:merokhetapp/model/farmer_model..dart';
import 'package:merokhetapp/services/customer_db.dart';
import 'package:merokhetapp/services/farmer_db.dart';
import 'package:merokhetapp/utils/error_dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Consumer? _userFromFirebaseUser(User? user) {
    return user != null
        ? Consumer(
            uid: user.uid,
            fullName: '',
            email: '',
            phoneNo: '',
            password: '',
            role: '')
        : null;
  }

  Farmer? _userFromFirebaseUserFarmer(User? user) {
    return user != null
        ? Farmer(
            uid: user.uid,
            fullName: '',
            email: '',
            phoneNo: '',
            password: '',
            role: '',
            farmAccountName: '',
            license: '',
            foodSafety: '')
        : null;
  }

  Stream<Consumer?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Stream<Farmer?> get farmer {
    return _auth.authStateChanges().map(_userFromFirebaseUserFarmer);
  }

  // Register with email and password
  Future registerWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    String fullName,
    String phone,
    String role, {
    String? farmAccountName,
    String? license,
    String? foodSafety,
    String? situation,
    String? business,
    String? productFocused,
    String? productNature,
    String? package,
    String? region,
    String? delivery,
  }) async {
    try {
      print('Email: $email');
      print('Password: $password');
      print('Full Name: $fullName');
      print('Phone: $phone');
      print('Role: $role');

      // Print optional parameters
      print('Farm Account Name: ${farmAccountName ?? "Not provided"}');
      print('License: ${license ?? "Not provided"}');
      print('Food Safety: ${foodSafety ?? "Not provided"}');
      print('Situation: ${situation ?? "Not provided"}');
      print('Business: ${business ?? "Not provided"}');
      print('Product Focused: ${productFocused ?? "Not provided"}');
      print('Product Nature: ${productNature ?? "Not provided"}');
      print('Package: ${package ?? "Not provided"}');
      print('Region: ${region ?? "Not provided"}');
      print('Delivery: ${delivery ?? "Not provided"}');
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      print(user);
      if (user == null) {
        ErrorDialog.showErrorDialog(
            context, "Registration failed. Please try again.");
        return;
      }

      if (role == 'farmer') {

        Farmer farmer = Farmer(
          uid: user.uid,
          fullName: fullName,
          email: email,
          phoneNo: phone,
          password: password,
          role: role,
          farmAccountName: farmAccountName ?? '',
          license: license ?? '',
          foodSafety: foodSafety ?? '',

        );
        FarmerDetails farmerDetails = FarmerDetails(
          farmerUid: user.uid,
          situation: situation,
          business: business,
          productFocused: productFocused,
          productNature: productNature,
          package: package,
          region: region ,
          delivery: delivery,

        );

        await FarmerDatabaseService(uid: user.uid).updateFarmerData(
          fullName: fullName,
          email: email,
          password: password,
          phone: phone,
          role: role,
          farmAccountName: farmAccountName ?? '',
          license: license ?? '',
          foodSafety: foodSafety ?? '',
          situation: situation ?? '',
          business: business ?? '',
          productFocused: productFocused ?? '',
          productNature: productNature ?? '',
          package: package ?? '',
          region: region ?? '',
          delivery: delivery ?? '',

        );
      } else if (role == 'consumer') {
        Consumer consumer = Consumer(
          uid: user.uid,
          fullName: fullName,
          email: email,
          phoneNo: phone,
          password: password,
          role: role,
        );

        await ConsumerDatabaseService(uid: user.uid).updateUserData(
          fullName: fullName,
          email: email,
          password: password,
          phone: phone,
          role: role,
        );
      } else {
        ErrorDialog.showErrorDialog(context,
            "Invalid role specified. Please choose 'farmer' or 'consumer'.");
        return;
      }

      print("User registered successfully as $role: ${user.uid}");
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "Error: $e");
    }
  }

  Future<Consumer?> logInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        ErrorDialog.showErrorDialog(context, "Login failed. Please try again.");
        return null;
      }

      print("User logged in: ${user.uid}");
      return _userFromFirebaseUser(user);
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "Error: $e");
      return null;
    }
  }
}
