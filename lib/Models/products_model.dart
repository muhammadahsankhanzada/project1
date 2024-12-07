import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String imageUrl;
  double price;
  int quantity;
  bool? isProductNew;
  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.isProductNew,
  });

  // Factory constructor to get and convert data recieved from Firestore document
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      quantity: data['quantity'].toInt() ?? 0,
      isProductNew: data['new'] ?? true,
    );
  }

  // Method to convert product data into json and sent to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'new': isProductNew,
    };
  }

  // Factory constructor to create a ProductsModel from a Map (JSON object)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      isProductNew: json['new'] ?? true,
    );
  }
}
