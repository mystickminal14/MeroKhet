import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/services/my_cart.dart';
import 'package:merokhetapp/utils/alert.dart';

class MyCartController {
  /// Adds an item to the consumer's cart
  Future<void> addCart({
    required BuildContext context,
    required String consumerId,
    required String vegetableId,
    required String vegetableName,required String price,

    required String status,
    required String quantity,
  }) async {
    try {
      await MyCartDatabaseService().addToCart(
        consumerId: consumerId,
        vegetableId: vegetableId,
        status: status,
        quantity: quantity,
        vegetableName:vegetableName,
        price:price
      );

      // Show success alert
      ShowAlert.showAlert(
        context,
        "Item added to cart successfully!",
        AlertType.success,
      );
    } catch (e) {
      // Show error dialog or alert
      ShowAlert.showAlert(
        context,
        "Error adding item to cart: $e",
        AlertType.error,
      );
    }
  }
  Future<List<Map<String, dynamic>>> getCartItems({
    required String consumerId,
  }) async {
    try {
      final cartCollection = FirebaseFirestore.instance.collection('my_cart');

      final querySnapshot = await cartCollection
          .where('consumerId', isEqualTo: consumerId)
          .get();

      final cartItems = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      return cartItems;
    } catch (e) {
      print("Error fetching cart items: $e");
      return [];
    }
  }

}
