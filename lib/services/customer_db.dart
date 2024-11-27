import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerDatabaseService {
  final String uid;
  ConsumerDatabaseService({required this.uid});

  final CollectionReference consumerCollection =
  FirebaseFirestore.instance.collection('consumers');

  // Update user data in Firestore
  Future<void> updateUserData({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) async {
    try {
      await consumerCollection.doc(uid).set({
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
      });

    } catch (e) {
      print("Error updating user data: $e");
      rethrow;
    }
  }
}
