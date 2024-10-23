import 'package:cloud_firestore/cloud_firestore.dart';

class Shops {
  String id, name, imageUrl, intro, type, address, timings, contact, email;
  Shops({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.intro,
    required this.type,
    required this.address,
    required this.timings,
    required this.contact,
    required this.email,
  });

  // Factory constructor to get and convert data recieved from Firestore document
  factory Shops.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Shops(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      intro: data['intro'] ?? '',
      type: data['type'] ?? '',
      address: data['address'] ?? '',
      timings: data['timings'] ?? '',
      contact: data['contact'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Method to convert product data into json and sent to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'intro': intro,
      'type': type,
      'address': address,
      'timings': timings,
      'contact': contact,
      'email': email,
    };
  }
}
