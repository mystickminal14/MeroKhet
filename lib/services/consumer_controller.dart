import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/utils/alert.dart';

class ConsumerController {

  Future<List<Map<String, dynamic>>> getConsumerByID(String id) async {

    try {
      final DocumentSnapshot consumerSnapshot = await FirebaseFirestore.instance
          .collection('consumers')
          .doc(id)
          .get();

      if (!consumerSnapshot.exists) {
        return [];
      }

      final conData = consumerSnapshot.data() as Map<String, dynamic>;
      return [
        {
          'consumer': {...conData, 'id': consumerSnapshot.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch farmer data: $e");
    }
  }
  Future<void> updateConsumerProfile(
      BuildContext context, String consumerId, Map<String, dynamic> updates) async {
    try {
      // Reference to the consumer document in Firestore
      DocumentReference consumerDocRef =
      FirebaseFirestore.instance.collection('consumers').doc(consumerId);

      // Update the consumer document with the provided fields
      await consumerDocRef.update(updates);

      // Show success alert
      ShowAlert.showAlert(
        context,
        "Consumer profile updated successfully!",
        AlertType.success,
      );
    } catch (e) {
      // Handle and display error alert
      ShowAlert.showAlert(
        context,
        "Error updating consumer profile: ${e.toString()}",
        AlertType.error,
      );
    }
  }

}

