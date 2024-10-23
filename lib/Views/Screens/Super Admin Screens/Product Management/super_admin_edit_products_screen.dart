import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminEditProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const SuperAdminEditProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<SuperAdminEditProductsScreen> createState() =>
      _SuperAdminEditProductsScreenState();
}

class _SuperAdminEditProductsScreenState
    extends State<SuperAdminEditProductsScreen> {
  var _formKey = GlobalKey<FormState>();
  var _productNameController = TextEditingController();
  var _productPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();
  String? selectedCategoryValue;

  List<String> categoryValuesList = [];

  // final List<String> categoryValuesList = [
  //   'Electronics',
  //   'Home Appliances',
  //   'Fashion'
  // ];
  String? selectedProductValue;

  List<String> productValuesList = [];
  // final List<String> productValuesList = [
  //   'Laptop',
  //   'Smart Phone',
  //   'Camera',
  //   'Tablet',
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

    // Products List
    fetchProducts().then((products) {
      productValuesList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Edit Products'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit a Product',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter product details to edit the product.',
                    style:
                        AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(height: 30),
                //Category DropDown

                productDropDownButton(
                  icon: Icons.grid_view,
                  hint: 'Select a Category',
                  currentSelectedValue: selectedCategoryValue,
                  dropDownValuesList: categoryValuesList,
                  onChanged: (String? newSelectedValue) {
                    selectedCategoryValue = newSelectedValue;
                    selectedProductValue = null;
                    setState(() {});
                    print(selectedCategoryValue);
                    // Products List
                    fetchProducts().then((products) {
                      productValuesList = products;
                    });
                  },
                ),
                SizedBox(height: 20),
                //Product DropDown
                Visibility(
                  visible: selectedCategoryValue != null,
                  child: Column(
                    children: [
                      productDropDownButton(
                        icon: Icons.fastfood,
                        hint: 'Select a Product',
                        currentSelectedValue: selectedProductValue,
                        dropDownValuesList: productValuesList,
                        onChanged: (String? newSelectedValue) {
                          selectedProductValue = newSelectedValue;
                          setState(() {});
                          print(selectedProductValue);
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Visibility(
                  visible: selectedProductValue != null,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Enter details which you want to update.',
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(height: 10),
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
                    ],
                  ),
                ),
                SizedBox(height: 10),
                UniversalButton(
                    buttonWidth: 250,
                    title: 'Save',
                    ontap: () async {
                      // if (_formKey.currentState!.validate()) {}
                      // List<String> cat = await fetchCategories();
                      // print('${cat}44');
                      // updateProduct(selectedProductValue!);
                      updateProduct(selectedProductValue!);
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
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
                color: AppColors.green,
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

  productDropDownButton({
    required IconData icon,
    required String hint,
    required String? currentSelectedValue,
    required List<String> dropDownValuesList,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
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
                icon,
                color: AppColors.green,
              ),
              SizedBox(width: 10),
              Text(
                hint,
                style: AppTextStyles.nameHeadingTextStyle(size: 15),
              ),
            ],
          ),
          value: currentSelectedValue,
          onChanged: onChanged,
          items:
              dropDownValuesList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.green,
                    ),
                    SizedBox(width: 10),
                    Text(
                      value,
                      style: AppTextStyles.nameHeadingTextStyle(size: 15),
                    ),
                  ],
                ));
          }).toList(),
        ),
      ),
    );
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

  // Method to fetch products list
  Future<List<String>> fetchProducts() async {
    List<String> products = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryValue)
        .collection('Products')
        .get()
        .then((QuerySnapshot productSnapshot) {
      products = productSnapshot.docs.map((doc) => doc.id).toList();
      setState(() {
        // print(products);
      });
    }).catchError((error) {
      print('Error getting data: $error');
    });
    return products;
  }

  // Update product details
  // Future<void> updateProduct(String productId) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Fetch the current product details
  //   DocumentSnapshot productSnapshot = await firestore
  //       .collection('Warehouses')
  //       .doc('Alpha Warehouse')
  //       .collection('Categories')
  //       .doc(selectedCategoryValue)
  //       .collection('Products')
  //       .doc(productId)
  //       .get();

  //   if (productSnapshot.exists) {
  //     var currentData = productSnapshot.data() as Map<String, dynamic>;

  //     Map<String, dynamic> updateData = {};

  //     // Only add fields to update if they have changed
  //     if (_productNameController.text.isNotEmpty &&
  //         _productNameController.text != currentData['name']) {
  //       updateData['name'] = _productNameController.text;
  //     }
  //     if (_productPriceController.text.isNotEmpty &&
  //         double.tryParse(_productPriceController.text) !=
  //             currentData['price']) {
  //       updateData['price'] = double.tryParse(_productPriceController.text);
  //     }
  //     if (_productQuantityController.text.isNotEmpty &&
  //         int.tryParse(_productQuantityController.text) !=
  //             currentData['quantity']) {
  //       updateData['quantity'] = int.tryParse(_productQuantityController.text);
  //     }

  //     // Update only if there's something to update
  //     if (updateData.isNotEmpty) {
  //       await firestore
  //           .collection('Warehouses')
  //           .doc('Alpha Warehouse')
  //           .collection('Categories')
  //           .doc(selectedCategoryValue)
  //           .collection('Products')
  //           .doc(productId)
  //           .update(updateData)
  //           .then((_) {
  //         print('Product updated successfully');
  //       }).catchError((error) {
  //         print('Failed to update product: $error');
  //       });
  //     } else {
  //       print('No changes detected, nothing to update.');
  //     }
  //   }
  // }

  // Update product method 2
  Future<void> updateProduct(String productId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Fetch the current product details
    DocumentSnapshot productSnapshot = await firestore
        .collection('Warehouses')
        .doc('Alpha Warehouse')
        .collection('Categories')
        .doc(selectedCategoryValue)
        .collection('Products')
        .doc(productId)
        .get();

    if (productSnapshot.exists) {
      var currentData = productSnapshot.data() as Map<String, dynamic>;

      // Prepare the new product name
      String newProductName = _productNameController.text.isNotEmpty
          ? _productNameController.text
          : currentData['name']; // Keep the current name if the field is empty

      // Create a new document with the new name as ID
      Map<String, dynamic> updateData = {
        'name': newProductName,
        'imageUrl': currentData['imageUrl'],
        'price': double.tryParse(_productPriceController.text) ??
            currentData['price'],
        'quantity': int.tryParse(_productQuantityController.text) ??
            currentData['quantity'],
        // Add other fields as necessary
      };

      // Check if the new name is different from the current ID
      if (newProductName != productId) {
        // Set the new document with the updated name
        await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(selectedCategoryValue)
            .collection('Products')
            .doc(newProductName)
            .set(updateData)
            .then((_) {
          print('Product updated successfully');

          // Delete the old document
          firestore
              .collection('Warehouses')
              .doc('Alpha Warehouse')
              .collection('Categories')
              .doc(selectedCategoryValue)
              .collection('Products')
              .doc(productId)
              .delete()
              .then((_) {
            print('Old product deleted successfully');
          }).catchError((error) {
            print('Failed to delete old product: $error');
          });
        }).catchError((error) {
          print('Failed to update product: $error');
        });
      } else {
        // If the name didn't change, just update the existing document
        await firestore
            .collection('Warehouses')
            .doc('Alpha Warehouse')
            .collection('Categories')
            .doc(selectedCategoryValue)
            .collection('Products')
            .doc(productId)
            .update(updateData)
            .then((_) {
          print('Product updated successfully without changing the ID');
        }).catchError((error) {
          print('Failed to update product: $error');
        });
      }
    }
  }
}
