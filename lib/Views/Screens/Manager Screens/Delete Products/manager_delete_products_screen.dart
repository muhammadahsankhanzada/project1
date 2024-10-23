import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerDeleteProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const ManagerDeleteProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<ManagerDeleteProductsScreen> createState() =>
      _ManagerDeleteProductsScreenState();
}

class _ManagerDeleteProductsScreenState
    extends State<ManagerDeleteProductsScreen> {
  final _formKey = GlobalKey<FormState>();
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
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: CustomAppbar(title: 'Delete Products'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Delete Product',
                    style: AppTextStyles.simpleHeadingTextStyle(
                        fontSize: 20,
                        textColor: AppColors.universalButtonGreen),
                  ),
                ),

                SizedBox(height: 20),
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

                UniversalButton(
                    buttonWidth: 250,
                    title: 'Delete Product',
                    borderRadius: 30,
                    ontap: () {
                      if (_formKey.currentState!.validate()) {}

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: Container(
                                height: 200,
                                width: 300,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.lightGreen,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      'Delete Product?',
                                      style:
                                          AppTextStyles.nameHeadingTextStyle(),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Are you sure you want to delete this product.',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        UniversalButton(
                                            title: 'Delete',
                                            buttonHeight: 40,
                                            buttonWidth: 110,
                                            buttonColor:
                                                AppColors.green.withOpacity(.7),
                                            ontap: () {
                                              deleteProduct(
                                                  selectedProductValue!);
                                              Navigator.pop(context);
                                              customSnackbar(
                                                  context, 'Product deleted.');
                                            }),
                                        UniversalButton(
                                            title: 'Cancel',
                                            buttonHeight: 40,
                                            buttonWidth: 110,
                                            buttonColor: AppColors.red.shade300,
                                            ontap: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
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

  // Method to delete a product
  Future<void> deleteProduct(String productId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('Warehouses')
          .doc('Alpha Warehouse')
          .collection('Categories')
          .doc(selectedCategoryValue)
          .collection('Products')
          .doc(productId)
          .delete();
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
}
