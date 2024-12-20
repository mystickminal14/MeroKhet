import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokhetapp/utils/alert.dart';
import 'package:merokhetapp/utils/error_dialog.dart';
import 'package:merokhetapp/services/vegetable.dart';

class VegService {
  Future<void> addProducts(
      BuildContext context,
      String img,
      String vegName,
      String category,
      String price,
      String stock,
      String? discount,
      String? total,
      String? disPrice,
      String description,
      String farmId, {
        String? userId,
        String? review,
        String? rating,
      }) async {
    try {
      if (vegName.isEmpty || category.isEmpty || description.isEmpty || price.isEmpty || stock.isEmpty) {
        throw Exception('Invalid data: Ensure all fields are valid.');
      }

      VegDatabaseService vegDatabaseService = VegDatabaseService(farmerId: farmId);


      await vegDatabaseService.addVegetablesData(
        img: img,
        name: vegName,
        category: category,
        price: price,
        stock: stock,
        discount: discount,
        total:total,
        disPrice: disPrice,
        description: description,
        reviews: {},
      );


    } catch (e) {
      ShowAlert.showAlert(
        context,
        "Error adding vegetable",
        AlertType.error,
      );

    }
  }


  Future<List<Map<String, dynamic>>> getFarmerByID(String farmerId) async {

    try {
      final DocumentSnapshot farmerSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerId)
          .get();

      if (!farmerSnapshot.exists) {
        return [];
      }

      final vegData = farmerSnapshot.data() as Map<String, dynamic>;
      return [
        {
          'farmer': {...vegData, 'id': farmerSnapshot.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch farmer data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllVegetablesWithFarmers() async {
    try {
      final QuerySnapshot vegSnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .get();

      final farmerIds = vegSnapshot.docs
          .map((doc) => doc['farmer_id'] as String)
          .toSet();

      final QuerySnapshot farmerSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .where(FieldPath.documentId, whereIn: farmerIds.toList())
          .get();

      final farmerMap = {
        for (var doc in farmerSnapshot.docs) doc.id: doc.data() as Map<String, dynamic>
      };

      return vegSnapshot.docs.map((vegDoc) {
        final vegData = vegDoc.data() as Map<String, dynamic>;
        final farmerId = vegData['farmer_id'];
        final farmerData = farmerMap[farmerId];
        return {
          'vegetable': {...vegData, 'id': vegDoc.id},
          'farmer': farmerData,
        };
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch vegetables with farmer data: $e");
    }
  }
  Future<List<Map<String, dynamic>>> getVegetablesById(String? id) async {
    try {
      final DocumentSnapshot vegSnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .doc(id)
          .get();

      if (!vegSnapshot.exists) {
        return [];
      }

      final vegData = vegSnapshot.data() as Map<String, dynamic>;
      return [
        {
          'vegetable': {...vegData, 'id': vegSnapshot.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch vegetable data: $e");
    }
  }
  Future<List<Map<String, dynamic>>> getAllVegetablesCatWithFarmers(String category) async {
    try {
      final QuerySnapshot vegSnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .where('category', isEqualTo: category)
          .get();

      final farmerIds = vegSnapshot.docs
          .map((doc) => doc['farmer_id'] as String)
          .toSet();

      final QuerySnapshot farmerSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .where(FieldPath.documentId, whereIn: farmerIds.toList())
          .get();

      final farmerMap = {
        for (var doc in farmerSnapshot.docs) doc.id: doc.data() as Map<String, dynamic>
      };

      return vegSnapshot.docs.map((vegDoc) {
        final vegData = vegDoc.data() as Map<String, dynamic>;
        final farmerId = vegData['farmer_id'];
        final farmerData = farmerMap[farmerId];
        return {
          'vegetable': {...vegData, 'id': vegDoc.id},
          'farmer': farmerData,
        };
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch vegetables with farmer data: $e");
    }
  }
  Future<List<Map<String, dynamic>>> getVegetablesByCategory(String category) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .where('category', isEqualTo: category)  // Filter by category
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      // Map the results into a List of Maps
      return querySnapshot.docs.map((doc) {
        final vegData = doc.data() as Map<String, dynamic>;
        return {...vegData, 'id': doc.id};  // Add the doc ID to the data
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch vegetables by category: $e");
    }
  }




  Future<List<Map<String, dynamic>>> getVegetablesByCategoryAndFarmerWithDetails(
      String? category, String farmerId) async {
    try {
      final QuerySnapshot vegSnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .where('category', isEqualTo: category)
          .where('farmer_id', isEqualTo: farmerId)
          .get();

      if (vegSnapshot.docs.isEmpty) {
        return [];
      }

      final DocumentSnapshot farmerDoc = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerId)
          .get();

      if (!farmerDoc.exists) {
        throw Exception('Farmer with ID $farmerId does not exist.');
      }

      final farmerData = farmerDoc.data() as Map<String, dynamic>;

      return vegSnapshot.docs.map((vegDoc) {
        final vegData = vegDoc.data() as Map<String, dynamic>;
        return {
          'vegetable': {...vegData, 'id': vegDoc.id},
          'farmer': {...farmerData, 'id': farmerDoc.id},
        };
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch vegetables and farmer data: $e");
    }
  }

  Future<Map<String, dynamic>?> getVegetableByFarmerAndVegId(
      String vegId, String farmerId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('vegetables')
          .where(FieldPath.documentId, isEqualTo: vegId)
          .where('farmer_id', isEqualTo: farmerId)
          .get();
      if (querySnapshot.docs.isEmpty) {
        throw Exception("No matching vegetable found for farmer with ID $farmerId.");
      }
      final vegDoc = querySnapshot.docs.first;
      final vegData = vegDoc.data();
      if (vegData['farmer_id'] != farmerId) {
        throw Exception("Vegetable does not belong to farmer with ID $farmerId.");
      }
      final farmerSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerId)
          .get();

      if (!farmerSnapshot.exists) {
        throw Exception("Farmer with ID $farmerId does not exist.");
      }
      final farmerData = farmerSnapshot.data() as Map<String, dynamic>;
      return {
        'vegetable': {...vegData, 'id': vegDoc.id},
        'farmer': {...farmerData, 'id': farmerSnapshot.id},
      };
    } catch (e) {
      throw Exception("Failed to fetch vegetable and farmer data: $e");
    }
  }


}

