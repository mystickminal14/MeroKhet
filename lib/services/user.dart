import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {
  final String uid;
  UserDatabaseService({required this.uid});

  // References to the farmer collections
  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');

  // Update farmer data in Firestore
  Future<void> updateUserData({
    required String password,
    required String email,
    required String role,
  }) async {
    try {
      await user.doc(uid).set({
        'email': email,
        'password': password,
        'role': role,
      });
      print("Farmer data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating farmer data: $e");
      rethrow;
    }
  }
}
