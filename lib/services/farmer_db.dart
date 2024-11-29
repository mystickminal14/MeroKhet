import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerDatabaseService {
  final String uid;

  FarmerDatabaseService({required this.uid});

  final CollectionReference farmerCollection =
  FirebaseFirestore.instance.collection('farmers');

  Future<void> updateFarmerData({
    required String fullName,
    required String email,
    required String phone,
    required String role,
    required String farmAccountName,
    required String license,
    required String foodSafety,
    required Map<String, dynamic> farmerDetails,
  }) async {
    try {
      await farmerCollection.doc(uid).set({
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'role': role,
        'farmAccountName': farmAccountName,
        'license': license,
        'foodSafety': foodSafety,
        'farmerDetails': farmerDetails,
      });

      print("Farmer data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating farmer data: $e");
      rethrow;
    }
  }
}
