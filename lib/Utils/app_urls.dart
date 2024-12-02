class AppUrls {
  static const baseUrl = 'http://10.0.2.2:5001/project1-4ee2b/us-central1/';
  static const login = baseUrl + 'api/login';
  static const String getManagerInfo =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getManagerInfo/';
  static const String getManagerPendingRequestsList =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getManagerPendingRequestsList/';
  static const String getManagerPendingRequestDetails =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getManagerPendingRequestDetails/';
  static const String getManagerApprovedRequestsList =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getManagerApprovedRequestsList/';
  static const String getManagerApprovedRequestDetails =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getManagerApprovedRequestDetails/';
  static const String getSalesmanRecords =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getSalesmanRecords/';
  static const String getSalesmanRecordsDetails =
      'http://10.0.2.2:5001/project1-4ee2b/us-central1/getSalesmanRecordsDetails/';
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
}
