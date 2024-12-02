class CategoriesModel {
  final name;
  final imageUrl;
  final productsCount;
  CategoriesModel({
    required this.name,
    required this.imageUrl,
    required this.productsCount,
  });

  // Factory constructor to create a CategoriesModel from a Map (JSON object)
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      productsCount: json['productsCount'] ?? 0,
    );
  }
}
