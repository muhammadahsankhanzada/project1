import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String imageUrl;
  // String category;
  double price;
  int quantity;
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  // Factory constructor to get and convert data recieved from Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      quantity: data['quantity'].toInt() ?? 0,
    );
  }

  // Method to convert product data into json and sent to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }
}
