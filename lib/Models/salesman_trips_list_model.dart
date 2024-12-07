class SalesmanTripsListModel {
  final String id;
  final String shopName;
  final String route;
  final int productsDelivered;
  final double amountRecieved;

  SalesmanTripsListModel({
    required this.id,
    required this.shopName,
    required this.route,
    required this.productsDelivered,
    required this.amountRecieved,
  });

  // Factory constructor to convert a JSON map to a Trip object
  factory SalesmanTripsListModel.fromMap(Map<String, dynamic> map, String id) {
    return SalesmanTripsListModel(
      id: id,
      shopName: map['shopName'] ?? '',
      route: map['route'] ?? '',
      productsDelivered: map['productsDelivered'] ?? 0,
      amountRecieved: map['amountRecieved'] ?? 0.0,
    );
  }
}
