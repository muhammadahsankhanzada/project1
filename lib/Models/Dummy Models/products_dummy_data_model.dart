class ProductsDummyDataModel {
  final String name;
  final String quantity;
  final String price;
  ProductsDummyDataModel({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

List<ProductsDummyDataModel> productsDummyDataModelContent = [
  ProductsDummyDataModel(
      name: 'Organic Ketchup', quantity: '2', price: '250.0'),
  ProductsDummyDataModel(name: 'Almond Butter', quantity: '1', price: '500.0'),
  ProductsDummyDataModel(name: 'Coconut Oil', quantity: '3', price: '300.0'),
  ProductsDummyDataModel(name: 'Quinoa', quantity: '1', price: '400.0'),
  ProductsDummyDataModel(name: 'Dark Chocolate', quantity: '5', price: '150.0'),
  ProductsDummyDataModel(name: 'Oat Milk', quantity: '4', price: '200.0'),
  ProductsDummyDataModel(name: 'Avocado Oil', quantity: '2', price: '450.0'),
  ProductsDummyDataModel(name: 'Chia Seeds', quantity: '6', price: '100.0'),
  ProductsDummyDataModel(name: 'Maple Syrup', quantity: '1', price: '350.0'),
  ProductsDummyDataModel(name: 'Brown Rice', quantity: '3', price: '150.0'),
];
