import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/utils/alert.dart';

class FarmerController {
  Future<void> updateFarmerProfile(
      BuildContext context, String consumerId, Map<String, dynamic> updates) async {
    try {
      // Reference to the consumer document in Firestore
      DocumentReference consumerDocRef =
      FirebaseFirestore.instance.collection('farmers').doc(consumerId);

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

  Future<List<Map<String, dynamic>>> getFarmerByID(String id) async {

    try {
      final DocumentSnapshot farmSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(id)
          .get();

      if (!farmSnapshot.exists) {
        return [];
      }

      final conData = farmSnapshot.data() as Map<String, dynamic>;
      return [
        {
          'farmer': {...conData, 'id': farmSnapshot.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch farmer data: $e");
    }

  }

   Future<void> updateFarmerImage(BuildContext context, String consumerId, String imageUrl) async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('farmers').doc(consumerId);
      await userDocRef.update({
        'image': imageUrl,
      });
      ShowAlert.showAlert(
        context,
        "Farmer image updated successfully!",
        AlertType.success,
      );
    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error updating farmer image: ${e.toString()}",
        AlertType.error,
      );
    }
  }


}

