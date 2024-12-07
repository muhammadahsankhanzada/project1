import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Models/products_model.dart';
import 'package:project1/Utils/app_urls.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class AddProductsViewModel with ChangeNotifier {
  String? selectedCategoryValue;
  File? pickedImage;
  String? imageUrl;
  List<String> categoryValuesList = [];

  // Show categories list
  Future<void> showCategories() async {
    List<String> categories = await fetchCategories();
    categoryValuesList = categories;
    notifyListeners();
  }

  // Change dropdown value
  void changeSelectedCategory(String? newValue) {
    selectedCategoryValue = newValue;
    notifyListeners();
  }

  // Pick image on tap of button
  Future<void> pickImageOntap() async {
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
          .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(pickedImage!);

      // Get the download URL
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
    }
    notifyListeners();
  }

  // Add product method
  Future<void> addProduct({
    required BuildContext context,
    required String productNameController,
    required String productPriceController,
    required String productQuantityController,
    required String productNewCategoryNameController,
    required List<String> warehouseList,
  }) async {
    String? categoryName;
    await uploadImage();

    if (productNameController.isNotEmpty &&
        categoryName != '' &&
        productPriceController.isNotEmpty &&
        productQuantityController.isNotEmpty &&
        imageUrl != null &&
        selectedCategoryValue != null) {
      warehouseList.forEach(
        (warehouse) async {
          String warehouseName = warehouse;
          categoryName = selectedCategoryValue == 'Other'
              ? productNewCategoryNameController
              : selectedCategoryValue;
          ProductModel newProduct = ProductModel(
            id: productNameController,
            name: productNameController,
            imageUrl: imageUrl!,
            price: double.parse(productPriceController),
            quantity: int.parse(productQuantityController),
          );
          /////////////////////////////
          try {
            final response = await http.post(
              Uri.parse(AppUrls.postAddProduct),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                {
                  ...newProduct.toMap(),
                  'warehouseName': warehouseName,
                  'categoryName': categoryName,
                },
              ),
            );
            if (response.statusCode == 200) {
              customSnackbar(context, 'Product Added Successfully');
              print('Product added successfully');
            } else {
              customSnackbar(context, 'Error Adding Product');

              print('Failed to add product');
            }
          } catch (error) {
            customSnackbar(context, 'Error Adding Product');
            print('Error: $error');
          }
          //   FirebaseFirestore firestore = FirebaseFirestore.instance;
          //   firestore
          //       .collection('Warehouses')
          //       .doc(warehouseName)
          //       .collection('Categories')
          //       .doc(categoryName)
          //       .collection('Products')
          //       .doc(newProduct.id)
          //       .set(newProduct.toMap())
          //       .then((_) {
          //     print('Document added with id: ${newProduct.id}');
          //     customSnackbar(context, 'Product Added Successfully');
          //     Navigator.pop(context);
          //   }).catchError((error) {
          //     print('Error adding: $error');
          //     customSnackbar(context, 'Error Adding Product');
          //   });
        },
      );
    } else {
      customSnackbar(context, 'Please fill all fields');
    }
    notifyListeners();
  }

  // Fetch categories method
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.getCategoriesList(
          warehouseName: Constants.defaultWarehouse)));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return List<String>.from(data['categoriesList']);
      } else {
        print('Failed to load categories');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
      print('Error fetching categories: $error');
      return [];
    }
  }

  // Reset screen data
  void resetState() {
    pickedImage = null;
    selectedCategoryValue = null;
    notifyListeners();
  }

  // // Method to fetch categories list
  // Future<List<String>> fetchCategories() async {
  //   List<String> categories = [];
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   await firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .get()
  //       .then((QuerySnapshot categorySnapshot) {
  //     categories = categorySnapshot.docs.map((doc) => doc.id).toList();
  //   }).catchError((error) {
  //     print('Error getting data: $error');
  //   });
  //   return categories;
  // }
}
