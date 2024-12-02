import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:http/http.dart' as http;

class ManagerPendingRequestsDetailsViewModel with ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchPendingRequestSummary(
      String salesmanId) async {
    try {
      final response =
          await http.get(Uri.parse(AppUrls.getManagerPendingRequestDetails));
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        return decodedResponse.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load the details');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching details: $error');
    }
  }

  // Future<void> moveData(String sourceDocId, String targetDocId) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Reference to the source document
  //   DocumentReference sourceDoc = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Managers')
  //       .doc('Ahsan')
  //       .collection('Pending Requests')
  //       .doc(sourceDocId);

  //   try {
  //     // Fetch the data from the source document
  //     DocumentSnapshot snapshot = await sourceDoc.get();
  //     if (snapshot.exists) {
  //       // Get the data you want to move
  //       Map<String, dynamic> dataToMove =
  //           snapshot.data() as Map<String, dynamic>;

  //       // Reference to the target document (or create a new one)
  //       DocumentReference targetDoc = firestore
  //           .collection('Users')
  //           .doc('Staff')
  //           .collection('Managers')
  //           .doc('Ahsan')
  //           .collection('Approved Requests')
  //           .doc(targetDocId);

  //       // Add data to the target document
  //       await targetDoc.set(dataToMove,
  //           SetOptions(merge: true)); // Use merge to keep existing data

  //       // Delete the source document after moving the data
  //       // await sourceDoc.delete();

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Data moved successfully!')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Source document not found!')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error moving data: $e')),
  //     );
  //   }
  // }
}
