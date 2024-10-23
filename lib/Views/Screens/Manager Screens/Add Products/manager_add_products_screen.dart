import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Models/products_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerAddProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const ManagerAddProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<ManagerAddProductsScreen> createState() =>
      _ManagerAddProductsScreenState();
}

class _ManagerAddProductsScreenState extends State<ManagerAddProductsScreen> {
  var _productNameController = TextEditingController();
  var _productPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();
  var _productNewCategoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCategoryValue;
  File? _pickedImage;
  String? _imageUrl;
  List<String> categoryValuesList = [];

  // final List<String> categoryValues = [
  //   'Electronics',
  //   'Home Appliances',
  //   'Fashion',
  //   'Other',
  // ];

  @override
  void initState() {
    super.initState();
    for (var warehouse in widget.warehouseList) {
      print(warehouse);
    }
    // Categories List
    fetchCategories().then((categories) {
      categoryValuesList = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Products'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Add New Product',
                    style: AppTextStyles.simpleHeadingTextStyle(
                        fontSize: 18,
                        textColor: AppColors.universalButtonGreen),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter the product details to add to your inventory.',
                    style:
                        AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      _pickedImage = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: _pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                fit: BoxFit.fill,
                                _pickedImage!,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 35,
                            )),
                ),
                SizedBox(height: 20),
                textField(
                    hint: 'Name',
                    icon: Icons.fastfood,
                    controller: _productNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product name required';
                      }
                      return null;
                    }),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Row(
                        children: [
                          Icon(
                            Icons.grid_view,
                            color: AppColors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Select Category',
                            style: AppTextStyles.nameHeadingTextStyle(size: 15),
                          ),
                        ],
                      ),
                      value: selectedCategoryValue,
                      onChanged: (String? newCategoryValue) {
                        selectedCategoryValue = newCategoryValue;
                        setState(() {});
                        print(selectedCategoryValue);
                      },
                      items: [
                        ...categoryValuesList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.grid_view,
                                    color: AppColors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    value,
                                    style: AppTextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  ),
                                ],
                              ));
                        }).toList(),
                        DropdownMenuItem<String>(
                            value: 'Other',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Other',
                                  style: AppTextStyles.nameHeadingTextStyle(
                                      size: 15),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: selectedCategoryValue == 'Other',
                  child: textField(
                      hint: 'New Category Name',
                      icon: Icons.new_label_outlined,
                      controller: _productNewCategoryNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter name of new category';
                        }
                        return null;
                      }),
                ),
                textField(
                    hint: 'Price',
                    icon: Icons.attach_money,
                    controller: _productPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product price required';
                      }
                      return null;
                    }),
                textField(
                    hint: 'Quantity',
                    icon: Icons.numbers,
                    controller: _productQuantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product quantity required';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                UniversalButton(
                    buttonWidth: 250,
                    borderRadius: 30,
                    title: 'Add New Product',
                    ontap: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedCategoryValue != null) {
                        String? categoryName;
                        await uploadImage();
                        print(_pickedImage);
                        print(_imageUrl);
                        if (_productNameController.text.isNotEmpty &&
                            categoryName != '' &&
                            _productPriceController.text.isNotEmpty &&
                            _productQuantityController.text.isNotEmpty &&
                            _imageUrl != null &&
                            selectedCategoryValue != null) {
                          widget.warehouseList.forEach((warehouse) {
                            String warehouseName = warehouse;
                            categoryName = selectedCategoryValue == 'Other'
                                ? _productNewCategoryNameController.text
                                : selectedCategoryValue;
                            Product newProduct = Product(
                              id: _productNameController.text.toString(),
                              // id: '',
                              name: _productNameController.text.toString(),
                              imageUrl: _imageUrl!,
                              price: double.parse(_productPriceController.text),
                              quantity:
                                  int.parse(_productQuantityController.text),
                            );
                            FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
                            firestore
                                .collection('Warehouses')
                                .doc(warehouseName)
                                .collection('Categories')
                                .doc(categoryName)
                                .collection('Products')
                                .doc(newProduct.id)
                                .set(newProduct.toMap())
                                .then((_) {
                              print('Document added with id: ${newProduct.id}');
                            }).catchError((error) {
                              print('Error adding: $error');
                            });
                          });
                        } else {
                          customSnackbar(context, 'Please fill all fields');
                        }
                      } else {
                        customSnackbar(context, 'Please fill all fields');
                      }
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required FormFieldValidator validator,
    required TextInputType keyboardType,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                icon,
                color: AppColors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Upload image to firebase storage and get imageUrl
  Future<void> uploadImage() async {
    if (_pickedImage == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(_pickedImage!);
      print('Picimage: $_pickedImage');
      // Get the download URL
      _imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  // Method to fetch categories list
  Future<List<String>> fetchCategories() async {
    List<String> categories = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .get()
        .then((QuerySnapshot categorySnapshot) {
      categories = categorySnapshot.docs.map((doc) => doc.id).toList();
      setState(() {
        // print(categories);
      });
    }).catchError((error) {
      print('Error getting data: $error');
    });
    return categories;
  }
}
