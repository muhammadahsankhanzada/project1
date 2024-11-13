import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Screens/General%20Screens/Product%20Management/add_products_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Product%20Management/delete_products_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/Product%20Management/edit_products_screen.dart';

class WarehouseSelectionViewModel with ChangeNotifier {
  bool _isSelectionModeOn = false;
  List<String> warehouseValuesList = [];
  List<bool> selectedWarehouses = [];

  bool get isSelectionModeOn => _isSelectionModeOn;

  set isSelectionModeOn(bool newValue) {
    _isSelectionModeOn = newValue;
    notifyListeners();
  }

  void updateSelectionMode() {
    isSelectionModeOn = selectedWarehouses.any((selected) => selected);
    notifyListeners();
  }

  void selectAll() {
    bool selectAll = !isSelectionModeOn;
    for (int i = 0; i < selectedWarehouses.length; i++) {
      selectedWarehouses[i] = selectAll;
    }
    isSelectionModeOn = selectAll;
    notifyListeners();
  }

  void onLongPress(int index) {
    isSelectionModeOn = true;
    selectedWarehouses[index] = !selectedWarehouses[index];
    updateSelectionMode();
    notifyListeners();
  }

  void onTap(int index) {
    selectedWarehouses[index] = !selectedWarehouses[index];
    updateSelectionMode();
    notifyListeners();
  }

  List<String> getSelectedWarehouseNames() {
    List<String> selectedWarehouseNames = [];
    for (int i = 0; i < selectedWarehouses.length; i++) {
      if (selectedWarehouses[i]) {
        selectedWarehouseNames.add(warehouseValuesList[i]);
      }
    }
    return selectedWarehouseNames;
  }

  goToDifferentScreens(String selectedScreen,
      List<String> selectedWarehouseNames, BuildContext context) {
    if (selectedScreen == 'Add Products') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddProductsScreen(warehouseList: selectedWarehouseNames)));
    }
    if (selectedScreen == 'Edit Products') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditProductsScreen(warehouseList: selectedWarehouseNames)));
    }
    if (selectedScreen == 'Delete Products') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DeleteProductsScreen(warehouseList: selectedWarehouseNames)));
    }
  }

  // Method to fetch warehouses list
  fetchWarehouses() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot warehouseSnapshot =
          await firestore.collection('Warehouses').get();
      warehouseValuesList =
          warehouseSnapshot.docs.map((doc) => doc.id).toList();
      selectedWarehouses = List<bool>.filled(warehouseValuesList.length, false);
    } catch (error) {
      print('Error getting data: $error');
    }
    notifyListeners();
  }

  // Method to reset the ViewModel state
  void resetViewModel() {
    _isSelectionModeOn = false;
    warehouseValuesList.clear();
    selectedWarehouses = [];
  }
}
