import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';

class CreateNewAccountViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          .child('users_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

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

  Future<void> registerUser({
    required BuildContext context,
    required String name,
    required String contact,
    required String password,
    required String confirmPassword,
    required String age,
    required String cnic,
    required String address,
    String email = '',
    String warehouse = '',
    String vehicle = '',
    String route = '',
  }) async {
    try {
      if (pickedImage != null) {
        if (password == confirmPassword) {
          // Creating salesman account
          if (selectedRoleValue == 'Salesman') {
            if (selectedVehicleValue != null) {
              await uploadImage();

              UserCredential userCredential =
                  await _auth.createUserWithEmailAndPassword(
                      email: contact + '@riq.com', password: password);
              User? user = userCredential.user;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc('Staff')
                    .collection('Salesmen')
                    .doc(name)
                    .set({
                  'name': name,
                  'imageUrl': imageUrl,
                  'contact': contact,
                  'age': int.parse(age),
                  'cnic': cnic,
                  'address': address,
                  'vehicle': selectedVehicleValue,
                  'route': route,
                }).then((_) {
                  print('Account created with id: ${name}');
                  Navigator.pop(context);
                  customSnackbar(
                      context, 'Salesman account successfully created');
                });
              }
            } else {
              customSnackbar(context, 'Select a vehicle');
            }
          }

          // Creating manager account
          if (selectedRoleValue == 'Manager') {
            if (selectedWarehouseValue != null) {
              await uploadImage();

              UserCredential userCredential =
                  await _auth.createUserWithEmailAndPassword(
                      email: contact + '@riq.com', password: password);
              User? user = userCredential.user;
              if (user != null) {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc('Staff')
                    .collection('Managers')
                    .doc(name)
                    .set({
                  'name': name,
                  'imageUrl': imageUrl,
                  'contact': contact,
                  'age': int.parse(age),
                  'cnic': cnic,
                  'address': address,
                  'email': email,
                  'warehouse': selectedWarehouseValue,
                }).then((_) {
                  print('Account created with id: ${name}');
                  Navigator.pop(context);
                  customSnackbar(
                      context, 'Manager account successfully created');
                });
              }
            } else {
              customSnackbar(context, 'Select a warehouse');
            }
          }

          // Creating admin account
          if (selectedRoleValue == 'Admin') {
            await uploadImage();

            UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
            User? user = userCredential.user;
            if (user != null) {
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc('Management')
                  .collection('Admins')
                  .doc(name)
                  .set({
                'name': name,
                'imageUrl': imageUrl,
                'contact': contact,
                'age': int.parse(age),
                'cnic': cnic,
                'address': address,
                'email': email,
              }).then((_) {
                print('Account created with id: ${name}');
                Navigator.pop(context);
                customSnackbar(context, 'Admin account successfully created');
              });
            }
          }
        } else {
          customSnackbar(context, 'Password not matched');
        }
      } else {
        customSnackbar(context, 'Select an image first');
      }
    } catch (error) {
      print('Error : $error');
      if (error.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        customSnackbar(
          context,
          'Phone number already in use by another account.',
          backgroundColor: AppColors.red,
        );
      } else {
        customSnackbar(
          context,
          error.toString().split('] ').last,
          backgroundColor: AppColors.red,
        );
      }
    }
  }

  // Reset screen state
  void resetState() {
    selectedRoleValue = null;
    selectedVehicleValue = null;
    selectedWarehouseValue = null;
    pickedImage = null;
    notifyListeners();
  }
}
