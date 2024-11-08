import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class DeleteShopViewModel with ChangeNotifier {
  bool isSearching = false;
  bool isShopSelected = false;
  String searchedText = '';
  String selectedShopName = '';
  String selectedShopImage = '';
  String selectedShopAddress = '';
  String selectedShopContact = '';
  String selectedShopEmail = '';

  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('Shops');

  // To filter shops on change
  void onChanged(String newValue) {
    isSearching = newValue.isNotEmpty;
    searchedText = newValue.toLowerCase();
    isShopSelected = false;
    notifyListeners();
  }

  // Method to delete a shop
  Future<void> deleteShop(String shopId, BuildContext context,
      BuildContext dialogBoxContext) async {
    try {
      Navigator.pop(dialogBoxContext);
      await firestore.doc(shopId).delete();
      isShopSelected = false;
      Navigator.pop(context);
      customSnackbar(context, 'Shop deleted successfully.');
    } catch (error) {
      customSnackbar(context, 'Failed to delete shop: $error');
    }
  }

  // Stream to fetch shops
  Stream<QuerySnapshot> get shopsStream {
    return FirebaseFirestore.instance.collection('Shops').snapshots();
  }

  // Method to filter shops based on search text
  List<QueryDocumentSnapshot> getFilteredShops(
      List<QueryDocumentSnapshot> shops) {
    return shops.where((shop) {
      final shopName = (shop['name'] ?? '').toLowerCase();
      return shopName.contains(searchedText);
    }).toList();
  }

  // Method to handle shop selection
  void selectShop(QueryDocumentSnapshot shop) {
    selectedShopName = shop['name'];
    selectedShopImage = shop['imageUrl'] ?? '';
    selectedShopAddress = shop['address'] ?? 'No Address';
    selectedShopContact = shop['contact'] ?? 'No Contact';
    selectedShopEmail = shop['email'] ?? 'No Email';
    isShopSelected = true;
    isSearching = false;
    searchedText = '';
    notifyListeners();
  }

  // Method to reset the ViewModel state
  void resetState() {
    isSearching = false;
    isShopSelected = false;
    searchedText = '';
    selectedShopName = '';
    selectedShopImage = '';
    selectedShopAddress = '';
    selectedShopContact = '';
    selectedShopEmail = '';
    notifyListeners();
  }
}
