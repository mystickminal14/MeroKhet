import 'package:cloud_firestore/cloud_firestore.dart';

class FarmerDatabaseService {
  final String uid;
  FarmerDatabaseService({required this.uid});

  // References to the farmer collections
  final CollectionReference farmerCollection =
  FirebaseFirestore.instance.collection('farmers');
  final CollectionReference farmerDetailCollection =
  FirebaseFirestore.instance.collection('farmerDetails');

  // Update farmer data in Firestore
  Future<void> updateFarmerData({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String role,
    required String farmAccountName,
    required String license,
    required String foodSafety,
    String? situation,
    String? business,
    String? productFocused,
    String? productNature,
    String? package,
    String? region,
    String? delivery,
  }) async {
    try {

      await farmerCollection.doc(uid).set({
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
        'farmAccountName': farmAccountName,
        'license': license,
        'foodSafety': foodSafety,
      });

      await farmerDetailCollection.doc(uid).set({
        'situation': situation,
        'business': business,
        'productFocused': productFocused,
        'productNature': productNature,
        'package': package,
        'region': region,
        'delivery': delivery,
      });

      print("Farmer data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating farmer data: $e");
      rethrow;
    }
  }
}
