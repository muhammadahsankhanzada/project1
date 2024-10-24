import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  String id, name, imageUrl, intro, type, address, timings, contact, email;
  Shop({
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
  factory Shop.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Shop(
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

  // Method to convert shop data into json and sent to Firestore document
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
