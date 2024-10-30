class AvailableProductsModel {
  final String name;
  final String imageUrl;
  final int quantity;
  AvailableProductsModel({
    required this.name,
    required this.imageUrl,
    required this.quantity,
  });
  @override
  String toString() {
    return 'AvailableProductsModel{name: $name, imageUrl: $imageUrl, quantity: $quantity}';
  }
}
