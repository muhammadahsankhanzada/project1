import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Models/shops_model.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class AddShopViewModel with ChangeNotifier {
  File? pickedImage;
  String? imageUrl;

  // To pick image on button tap
  Future<void> pickImageOnTap() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
    }
    notifyListeners();
  }

  // Upload image to firebase storage and get imageUrl
  Future<void> uploadImage() async {
    if (pickedImage == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('shops_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(pickedImage!);
      print('Picimage: $pickedImage');
      // Get the download URL
      imageUrl = await ref.getDownloadURL();
      print(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
    notifyListeners();
  }

  // Method to add shop
  addShop({
    required String id,
    required String nameController,
    required String introController,
    required String typeController,
    required String addressController,
    required String timingsController,
    required String contactController,
    required String emailController,
    required BuildContext context,
  }) async {
    await uploadImage();
    if (nameController.isNotEmpty &&
        introController.isNotEmpty &&
        typeController.isNotEmpty &&
        addressController.isNotEmpty &&
        timingsController.isNotEmpty &&
        contactController.isNotEmpty &&
        emailController.isNotEmpty &&
        imageUrl != null) {
      ShopsModel newShop = ShopsModel(
        id: id,
        name: nameController,
        imageUrl: imageUrl!,
        intro: introController,
        type: typeController,
        address: addressController,
        timings: timingsController,
        contact: contactController,
        email: emailController,
      );

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('Shops')
          .doc(newShop.id)
          .set(newShop.toMap())
          .then((_) {
        print('Shop added with id: ${newShop.id}');
        Navigator.pop(context);
        customSnackbar(context, 'Shop Added Successfully');
      }).catchError((error) {
        print('Error adding: $error');
        customSnackbar(context, 'Error Adding Shop');
      });
    } else {
      customSnackbar(context, 'Please fill all fields');
    }
    notifyListeners();
  }
}
