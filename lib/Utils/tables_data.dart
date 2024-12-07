class TablesData {
  static final salesmanCartTable = SalesmanCartTable();
  static const dbName = 'firstProject.db';
}

class SalesmanCartTable {
  final String tableName = 'SalesmanCart';
  final String productId = 'productId';
  final String productName = 'productName';
  final String productImage = 'productImage';
  final String productType = 'productType';
  final String productQuantity = 'productQuantity';
  final String productPrice = 'productPrice';
  final String dateTime = 'dateTime';
}
