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
    required String farmerId,
    required String status,
    required String image,
    required String quantity,
  }) async {
    try {
      await MyCartDatabaseService().addToCart(
        consumerId: consumerId,
        vegetableId: vegetableId,
        farmerId:farmerId,
        status: status,
        quantity: quantity,
        vegetableName:vegetableName,
        price:price, image: image
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

  Future<void> delete({
    required BuildContext context,
    required String orderId,
  }) async {
    try {
      final orderCollection =
      FirebaseFirestore.instance.collection('order');
      await orderCollection.doc(orderId).delete();
      ShowAlert.showAlert(
        context,
        "Order cancelled successfully",
        AlertType.success,
      );
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error deleting order: $e",
        AlertType.error,
      );
    }
  }
  Future<void> orderListOfItems({
    required BuildContext context,
    required List<Map<String, dynamic>> orderedData,
  }) async {
    try {
      final orderCollection =
      FirebaseFirestore.instance.collection('order');
      final myCartCollection =
      FirebaseFirestore.instance.collection('my_cart');

      for (var item in orderedData) {
        await orderCollection.add(item);
      }

      for (var item in orderedData) {
        final cartItemRef = myCartCollection.doc(item['cartId']);
        await cartItemRef.update({'status': 'completed'});
      }
      ShowAlert.showAlert(
        context,
        "Order Placed Successfully!!",
        AlertType.success,
      );
    } catch (e) {
      // Show error alert if there's an issue
      ShowAlert.showAlert(
        context,
        "Error placing order $e",
        AlertType.error,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getOrder(
      {required BuildContext context,
        required String uuid,
        required String status}) async {
    try {
      final orderCollection =
      FirebaseFirestore.instance.collection('order');

      final querySnapshot = await orderCollection
          .where('consumerId', isEqualTo: uuid)
          .where('status', isEqualTo: status)
          .get();

      final orderItems = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
      return orderItems;
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error adding item to cart: $e",
        AlertType.error,
      );
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCartItems({
    required String consumerId,required String status
  }) async {
    try {
      final cartCollection = FirebaseFirestore.instance.collection('my_cart');

      final querySnapshot = await cartCollection
          .where('consumerId', isEqualTo: consumerId)
          .where('status', isEqualTo: status)
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
