class AppUrls {
  static const baseUrl = 'http://10.0.2.2:5001/project1-4ee2b/us-central1/';

  static const login = baseUrl + 'api/login';

  // Get Request Urls
  static const String getManagerInfo = baseUrl + 'getManagerInfo/';

  static const String getManagerPendingRequestsList =
      baseUrl + 'getManagerPendingRequestsList/';

  static const String getManagerPendingRequestDetails =
      baseUrl + 'getManagerPendingRequestDetails/';

  static const String getManagerApprovedRequestsList =
      baseUrl + 'getManagerApprovedRequestsList/';

  static const String getManagerApprovedRequestDetails =
      baseUrl + 'getManagerApprovedRequestDetails/';

  static const String getSalesmanRecords = baseUrl + 'getSalesmanRecords/';

  static const String getSalesmanRecordsDetails =
      baseUrl + 'getSalesmanRecordsDetails/';

  static String getInventory(
      {required String warehouseName, required String isNewProducts}) {
    return baseUrl +
        'getInventory/?warehouseName=$warehouseName&newProducts=$isNewProducts';
  }

  static String getInventoryNewItems(
      {required String warehouseName, required String selectedCategoryName}) {
    return baseUrl +
        'getInventoryNewItems/?warehouseName=$warehouseName&selectedCategoryName=$selectedCategoryName';
  }

  static String getInventoryReturnItems(
      {required String warehouseName, required String selectedCategoryName}) {
    return baseUrl +
        'getInventoryReturnItems/?warehouseName=$warehouseName&selectedCategoryName=$selectedCategoryName';
  }

  static const String getWarehousesList = baseUrl + 'getWarehousesList';

  static String getCategoriesList({required String warehouseName}) {
    return baseUrl + 'getCategoriesList/?warehouseName=$warehouseName';
  }

  static String getProdutsList(
      {required String warehouseName, required String categoryName}) {
    return baseUrl +
        'getProductsList/?warehouseName=$warehouseName&categoryName=$categoryName';
  }

  static String getProdutsWithData(
      {required String warehouseName, required String categoryName}) {
    return baseUrl +
        'getProductsWithData/?warehouseName=$warehouseName&categoryName=$categoryName';
  }

  static String getSalesmanTripsList({required String salesmanName}) {
    return baseUrl + 'getSalesmanTripsList/?salesmanName=$salesmanName';
  }

  static String getSalesmanInfo({required String salesmanName}) {
    return baseUrl + 'getSalesmanInfo/?salesmanName=$salesmanName';
  }

  // Post Request Urls
  static const String postAddProduct = baseUrl + 'postAddProduct';

  static const String postDeleteProduct = baseUrl + 'postDeleteProduct';
}
