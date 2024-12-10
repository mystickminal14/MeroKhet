import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartDatabaseService {
  final CollectionReference myCartCollection =
      FirebaseFirestore.instance.collection('my_cart');

  MyCartDatabaseService();

  /// Adds or updates an item in the cart
  Future<void> addToCart(
      {required String consumerId,
      required String vegetableId,
      required String status,
      required String quantity,
        required String image,
      required String vegetableName,
        required String farmerId,
      required String price}) async {
    try {
      // Construct a unique document ID
      String documentId = '${consumerId}_$vegetableId';

      // Add or update the cart item in Firestore
      await myCartCollection.doc(documentId).set({
        'consumerId': consumerId,
        'vegetableId': vegetableId,
        'status': status,
        'quantity': quantity,
        'image': image,
        'vegetableName': vegetableName,
        'price': price,
        'farmerId':farmerId,

        'updatedAt': FieldValue.serverTimestamp(),
      });

      print("Cart data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating cart data: $e");
      rethrow;
    }
  }
}
