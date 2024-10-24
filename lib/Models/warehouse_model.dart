import 'package:cloud_firestore/cloud_firestore.dart';

class Warehouse {
  String id,
      name,
      imageUrl,
      address,
      managerName,
      contact,
      email,
      totalEmployees,
      storageCapacity,
      loadingDocks,
      entries,
      spaceAvailable;
  Warehouse({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.managerName,
    required this.contact,
    required this.email,
    required this.totalEmployees,
    required this.storageCapacity,
    required this.loadingDocks,
    required this.entries,
    required this.spaceAvailable,
  });

  // Factory constructor to get and convert data recieved from Firestore document
  factory Warehouse.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Warehouse(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      address: data['address'] ?? '',
      managerName: data['managerName'] ?? '',
      contact: data['contact'] ?? '',
      email: data['email'] ?? '',
      totalEmployees: data['totalEmployees'] ?? '',
      storageCapacity: data['storageCapacity'] ?? '',
      loadingDocks: data['loadingDocks'] ?? '',
      entries: data['entries'] ?? '',
      spaceAvailable: data['spaceAvailable'] ?? '',
    );
  }

  // Method to convert warehouse data into json and sent to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'address': address,
      'managerName': managerName,
      'contact': contact,
      'email': email,
      'totalEmployees': totalEmployees,
      'storageCapacity': storageCapacity,
      'loadingDocks': loadingDocks,
      'entries': entries,
      'spaceAvailable': spaceAvailable,
    };
  }
}
