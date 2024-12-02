import 'package:cloud_firestore/cloud_firestore.dart';

class VegDatabaseService {
  final String farmerId;

  VegDatabaseService({required this.farmerId});

  final CollectionReference vegCollection = FirebaseFirestore.instance.collection('vegetables');

  Future<void> addVegetablesData({
    required String img,
    required String name,
    required String category,
    required String price,
    required String stock,
    String? discount,
    String? total,
    String? disPrice,
    required String description,
    required Map<String, dynamic> reviews,
  }) async {
    try {
      // Add a new document with an auto-generated ID
      DocumentReference docRef = await vegCollection.add({
        'farmer_id': farmerId,
        'name': name,
        'image':img,
        'category': category,
        'price': price,
        'stock': stock,
        'discount': discount,
        'discountedPrice': disPrice,
        'totalPrice': total,
        'description': description,
        'reviews': reviews,
      });

      print("Vegetable added successfully with ID: ${docRef.id}");
    } catch (e) {
      print("Error adding vegetable data: $e");
      rethrow;
    }
  }

  Future<void> updateVegetablesData({
    required String id, // Pass the document ID when updating
    required String img,
    required String name,
    required String category,
    required String price,
    required String stock,
    String? sold,
    String? status,
    String? discount,
    required String description,
    required Map<String, dynamic> reviews,
  }) async {
    try {

      if (name.isEmpty || category.isEmpty || description.isEmpty || price.isEmpty || stock.isEmpty) {
        throw Exception('Required fields must not be empty.');
      }

      await vegCollection.doc(id).set({
        'farmer_id': farmerId,
        'name': name,
        'category': category,
        'price': price,
        'stock': stock,
        'discount': discount,
        'description': description,
        'reviews': reviews,
      }, SetOptions(merge: true));

      print("Vegetable updated successfully in Firestore.");
    } catch (e) {
      print("Error updating vegetable data: $e");
      rethrow;
    }
  }
}
