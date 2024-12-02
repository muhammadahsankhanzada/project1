import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class DeleteWarehouseViewModel with ChangeNotifier {
  bool isSearching = false;
  bool isWarehouseSelected = false;
  String searchedText = '';
  String selectedWarehouseName = '';
  String selectedWarehouseImage = '';
  String selectedWarehouseAddress = '';
  String selectedWarehouseContact = '';
  String selectedWarehouseEmail = '';

  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('Warehouses');

  // To filter warehouses on change
  void onChanged(String newValue) {
    isSearching = newValue.isNotEmpty;
    searchedText = newValue.toLowerCase();
    isWarehouseSelected = false;
    notifyListeners();
  }

  // Method to delete a warehouse
  Future<void> deleteWarehouse(String warehouseId, BuildContext context,
      BuildContext dialogBoxContext) async {
    try {
      Navigator.pop(dialogBoxContext);
      await firestore.doc(warehouseId).delete();
      isWarehouseSelected = false;
      Navigator.pop(context);
      customSnackbar(context, 'Warehouse deleted successfully.');
    } catch (error) {
      customSnackbar(context, 'Failed to delete warehouse: $error');
    }
  }

  // Stream to fetch warehouses
  Stream<QuerySnapshot> get warehousesStream {
    return FirebaseFirestore.instance.collection('Warehouses').snapshots();
  }

  // Method to filter warehouses based on search text
  List<QueryDocumentSnapshot> getFilteredWarehouses(
      List<QueryDocumentSnapshot> warehouses) {
    return warehouses.where((warehouse) {
      final warehouseName = (warehouse['name'] ?? '').toLowerCase();
      return warehouseName.contains(searchedText);
    }).toList();
  }

  // Method to handle warehouse selection
  void selectWarehouse(QueryDocumentSnapshot warehouse) {
    selectedWarehouseName = warehouse['name'];
    selectedWarehouseImage = warehouse['imageUrl'] ?? '';
    selectedWarehouseAddress = warehouse['address'] ?? 'No Address';
    selectedWarehouseContact = warehouse['contact'] ?? 'No Contact';
    selectedWarehouseEmail = warehouse['email'] ?? 'No Email';
    isWarehouseSelected = true;
    isSearching = false;
    searchedText = '';
    notifyListeners();
  }

  // Method to reset the ViewModel state
  void resetState() {
    isSearching = false;
    isWarehouseSelected = false;
    searchedText = '';
    selectedWarehouseName = '';
    selectedWarehouseImage = '';
    selectedWarehouseAddress = '';
    selectedWarehouseContact = '';
    selectedWarehouseEmail = '';
    notifyListeners();
  }
}
