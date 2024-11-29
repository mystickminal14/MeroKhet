import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/customer_db.dart';
import 'package:merokhetapp/services/farmer_db.dart';
import 'package:merokhetapp/services/user.dart';
import 'package:merokhetapp/utils/error_dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(uid: user.uid , email: '', password: '', role: '')
        : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

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
      // Validate role
      if (role != 'farmer' && role != 'consumer') {
        ErrorDialog.showErrorDialog(context, "Invalid role specified.");
        return;
      }

      // Register the user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        ErrorDialog.showErrorDialog(context, "Registration failed.");
        return;
      }

      // Update data in Firestore based on role
      if (role == 'farmer') {
        Map<String, dynamic> farmerDetails = {
          'situation': situation ?? '',
          'business': business ?? '',
          'productFocused': productFocused ?? '',
          'productNature': productNature ?? '',
          'package': package ?? '',
          'region': region ?? '',
          'delivery': delivery ?? '',
        };

        await FarmerDatabaseService(uid: user.uid).updateFarmerData(
          fullName: fullName,
          email: email,
          phone: phone,
          role: role,
          farmAccountName: farmAccountName ?? '',
          license: license ?? '',
          foodSafety: foodSafety ?? '',
          farmerDetails: farmerDetails,
        );
      } else if (role == 'consumer') {
        // Update consumer-specific data
        await ConsumerDatabaseService(uid: user.uid).updateCustomerData(
          fullName: fullName,
          email: email,
          phone: phone,
          password: password,
          role: role,
        );
      }

      // Update generic user data
      await UserDatabaseService(uid: user.uid).updateUserData(
        email: email,
        password: password,
        role: role,
      );

      print("User registered successfully as $role: ${user.uid}");
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "Error: $e");
    }
  }

  Future<UserModel?> logInWithEmailAndPassword(
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
