import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/utils/error_dialog.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user, Map<String, dynamic>? userData) {
    return user != null && userData != null
        ? UserModel(
      uid: user.uid,
      email: userData['email'] ?? '',
      password: '',
      role: userData['role'] ?? '',
    )
        : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) return null;

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) return null;

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return _userFromFirebaseUser(user, userData);
    });
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

      // Register user in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        ErrorDialog.showErrorDialog(context, "Registration failed.");
        return;
      }

      // Prepare Firestore data
      Map<String, dynamic> userData = {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': role,
      };

      if (role == 'farmer') {
        userData.addAll({
          'farmAccountName': farmAccountName ?? '',
          'license': license ?? '',
          'foodSafety': foodSafety ?? '',
          'situation': situation ?? '',
          'business': business ?? '',
          'productFocused': productFocused ?? '',
          'productNature': productNature ?? '',
          'package': package ?? '',
          'region': region ?? '',
          'delivery': delivery ?? '',
        });
      }

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userData);

      print("User registered successfully as $role: ${user.uid}");
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "Error during registration: ${e.toString()}");
    }
  }

  /// Logs in a user with email and password.
  Future<UserModel?> logInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // Step 1: Authenticate with Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        ErrorDialog.showErrorDialog(context, "Login failed. Please try again.");
        return null;
      }

      // Step 2: Fetch user details from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        ErrorDialog.showErrorDialog(context, "User not found in database.");
        return null;
      }

      // Map Firestore data to `UserModel`
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return _userFromFirebaseUser(user, data);
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "Error during login: ${e.toString()}");
      return null;
    }
  }

  /// Logs out the currently authenticated user.
  Future<void> signOut() async {
    await _auth.signOut();
    print("User signed out successfully.");
  }
}
