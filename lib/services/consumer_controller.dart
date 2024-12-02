import 'package:cloud_firestore/cloud_firestore.dart';

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

}

