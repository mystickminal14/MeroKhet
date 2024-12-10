import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/model/user_model.dart';
import 'package:merokhetapp/services/customer_db.dart';
import 'package:merokhetapp/services/farmer_db.dart';
import 'package:merokhetapp/services/user.dart';
import 'package:merokhetapp/utils/alert.dart';
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

      String role,
      String? img,{
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
          image:img??"",
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
          role: role, img: img??"",
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
      // Step 1: Authenticate with Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user == null) {
        ShowAlert.showAlert(
          context,
          "Login failed! Please try again!",
          AlertType.error,
        );
        return null;
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        ShowAlert.showAlert(
          context,
          "User not found!!",
          AlertType.error,
        );
        return null;
      }

      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return _userFromFirebaseUser(user, data);
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error during login: ${e.toString()}",
        AlertType.error,
      );
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    print("User signed out successfully.");
  }Future passwordReset(BuildContext context,email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      ShowAlert.showAlert(
        context,
        'Email verification has been sent to your Gmail account!',
        AlertType.success,
      );
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Email doesnot exist",
        AlertType.error,
      );
    }
  }
  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      print("User signed out successfully.");

      // Optionally, you can navigate the user to a different screen after logging out.
      // For example, navigate to the login screen:
      Navigator.pushReplacementNamed(context, '/login');

      ShowAlert.showAlert(
        context,
        "You have successfully logged out.",
        AlertType.success,
      );
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error during logout: ${e.toString()}",
        AlertType.error,
      );
    }
  }
  Future<void> updateConsumerImage(BuildContext context, String consumerId, String imageUrl) async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('consumers').doc(consumerId);
      await userDocRef.update({
        'image': imageUrl,
      });
      ShowAlert.showAlert(
        context,
        "Consumer image updated successfully!",
        AlertType.success,
      );
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error updating consumer image: ${e.toString()}",
        AlertType.error,
      );
    }
  }


}