import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDeleteAccountViewModel with ChangeNotifier {
  bool _isUserNameSelected = false;
  bool _isSearching = false;
  String _searchedText = '';

  // Selected user details
  String _selectedUserName = '';
  String _selectedUserImage = '';
  String _selectedUserAddress = '';
  String _selectedUserContact = '';
  String _selectedUserEmail = '';

  // Getters
  bool get isUserNameSelected => _isUserNameSelected;
  bool get isSearching => _isSearching;
  String get searchedText => _searchedText;
  String get selectedUserName => _selectedUserName;
  String get selectedUserImage => _selectedUserImage;
  String get selectedUserAddress => _selectedUserAddress;
  String get selectedUserContact => _selectedUserContact;
  String get selectedUserEmail => _selectedUserEmail;

  // Setters
  set isUserNameSelected(newValue) {
    _isUserNameSelected = newValue;
    notifyListeners();
  }

  set isSearching(newValue) {
    _isSearching = newValue;
    notifyListeners();
  }

  set searchedText(newValue) {
    _searchedText = newValue;
    notifyListeners();
  }

  set selectedUserName(newValue) {
    _selectedUserName = newValue;
    notifyListeners();
  }

  set selectedUserImage(newValue) {
    _selectedUserImage = newValue;
    notifyListeners();
  }

  set selectedUserAddress(newValue) {
    _selectedUserAddress = newValue;
    notifyListeners();
  }

  set selectedUserContact(newValue) {
    _selectedUserContact = newValue;
    notifyListeners();
  }

  set selectedUserEmail(newValue) {
    _selectedUserEmail = newValue;
    notifyListeners();
  }

  void onChanged(String value) {
    isSearching = value.isNotEmpty;
    searchedText = value.toLowerCase();
    isUserNameSelected = false;
    notifyListeners();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> filterUsernames(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    final result = data.where((user) {
      final userName = (user['name'] ?? '').toLowerCase();
      return userName.contains(searchedText);
    }).toList();
    return result;
  }

  // Method to fetch user records
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserRecords() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Salesmen')
        .snapshots();
    return data;
  }
}
