import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class ManagerAddProductsScreen extends StatefulWidget {
  const ManagerAddProductsScreen({super.key});

  @override
  State<ManagerAddProductsScreen> createState() =>
      _ManagerAddProductsScreenState();
}

class _ManagerAddProductsScreenState extends State<ManagerAddProductsScreen> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();
  final productCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Products',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Add New Product',
                style: AppTextStyles.nameHeadingTextStyle(size: 20),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Enter the product details to add to your inventory.',
                style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: productNameController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Product name required';
              //   }
              //   return null;
              // },
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
                prefixIcon: Icon(
                  Icons.fastfood,
                  color: AppColors.green,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
