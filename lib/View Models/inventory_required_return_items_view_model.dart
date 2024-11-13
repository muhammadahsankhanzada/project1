import 'package:flutter/material.dart';

class InventoryRequiredReturnItemsViewModel with ChangeNotifier {
  // Selected Tab index
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  set selectedTabIndex(int newIndex) {
    _selectedTabIndex = newIndex;
  }

  // Update the selected tab index
  void onTabChanged(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
