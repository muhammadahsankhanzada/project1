import 'package:flutter/material.dart';

class AdminCreateNewAccountViewModel with ChangeNotifier {
  String? selectedRoleValue;
  final List<String> roleValuesList = [
    'Salesman',
    'Manager',
    'Admin',
  ];

  String? selectedVehicleValue;
  List<String> vehicleValuesList = [
    'Alto (20393)',
    'Suzuki (32030)',
    'Mehran (39843)',
  ];

  String? selectedWarehouseValue;
  List<String> warehouseValuesList = [
    'Alpha Warehouse',
    'Charlie Warehouse',
    'Bravo Warehouse',
    'Echo Warehouse',
  ];

  updateRoleDropDownValue(String newValue) {
    selectedRoleValue = newValue;
    notifyListeners();
  }

  updateVehicleDropDownValue(String newValue) {
    selectedVehicleValue = newValue;
    notifyListeners();
  }

  updateWarehouseDropDownValue(String newValue) {
    selectedWarehouseValue = newValue;
    notifyListeners();
  }
}
