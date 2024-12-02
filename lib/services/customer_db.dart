import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerDatabaseService {
  final String uid;

  ConsumerDatabaseService({required this.uid});

  final CollectionReference consumerCollection =
  FirebaseFirestore.instance.collection('consumers');

  Future<void> updateCustomerData({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
    required String img,
  }) async {
    try {
      await consumerCollection.doc(uid).set({
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'image': img,
        'role': role,
        'password':password,

      });

      print("Consumer data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating consumer data: $e");
      rethrow;
    }
  }
}