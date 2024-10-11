class CartDummyModel {
  final String image;
  final String name;
  int quantity;
  final double price;
  CartDummyModel({
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

List<CartDummyModel> driverCartContents = [
  CartDummyModel(
    image: 'assets/images/item1.png', // Replace with your image path
    name: 'Apple',
    quantity: 3,
    price: 200, // Price per item
  ),
  CartDummyModel(
    image: 'assets/images/item2.png', // Replace with your image path
    name: 'Banana',
    quantity: 5,
    price: 100, // Price per item
  ),
  CartDummyModel(
    image: 'assets/images/item3.png', // Replace with your image path
    name: 'Orange',
    quantity: 2,
    price: 150, // Price per item
  ),
  CartDummyModel(
    image: 'assets/images/item4.png', // Replace with your image path
    name: 'Grapes',
    quantity: 1,
    price: 250, // Price per item
  ),
  CartDummyModel(
    image: 'assets/images/item5.png', // Replace with your image path
    name: 'Pineapple',
    quantity: 4,
    price: 300, // Price per item
  ),
];
