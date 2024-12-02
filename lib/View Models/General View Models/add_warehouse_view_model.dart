import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Models/warehouse_model.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class AddWarehouseViewModel with ChangeNotifier {
  File? pickedImage;
  String? imageUrl;

  // Pick image on button tap
  Future<void> pickImageOnTap() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  // Method to upload image to firebase storage and get imageUrl
  Future<void> uploadImage() async {
    if (pickedImage == null) return;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('shops_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(pickedImage!);
      print('Picked image: $pickedImage');
      // Get the download URL
      imageUrl = await ref.getDownloadURL();
      print(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
    notifyListeners();
  }

  // Add warehouse method
  void addWarehouse({
    required String id,
    required String nameController,
    required String addressController,
    required String managerNameController,
    required String contactController,
    required String emailController,
    required String totalEmployeesController,
    required String storageCapacityController,
    required String loadingDocksController,
    required String entriesController,
    required String spaceAvailableController,
    required BuildContext context,
  }) async {
    await uploadImage();
    if (nameController.isNotEmpty &&
        addressController.isNotEmpty &&
        managerNameController.isNotEmpty &&
        contactController.isNotEmpty &&
        emailController.isNotEmpty &&
        totalEmployeesController.isNotEmpty &&
        storageCapacityController.isNotEmpty &&
        loadingDocksController.isNotEmpty &&
        entriesController.isNotEmpty &&
        spaceAvailableController.isNotEmpty &&
        imageUrl != null) {
      WarehouseModel newWarehouse = WarehouseModel(
        id: id,
        name: nameController,
        imageUrl: imageUrl!,
        address: addressController,
        managerName: managerNameController,
        contact: contactController,
        email: emailController,
        totalEmployees: totalEmployeesController,
        storageCapacity: storageCapacityController,
        loadingDocks: loadingDocksController,
        entries: entriesController,
        spaceAvailable: spaceAvailableController,
      );

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('Warehouses')
          .doc(newWarehouse.id)
          .set(newWarehouse.toMap())
          .then((_) {
        print('Warehouse added with id: ${newWarehouse.id}');
        Navigator.pop(context);
        customSnackbar(context, 'Warehouse Added Successfully');
      }).catchError((error) {
        print('Error adding: $error');
        customSnackbar(context, 'Error Adding Warehouse');
      });
    } else {
      customSnackbar(context, 'Please fill all fields');
    }
    notifyListeners();
  }
}
