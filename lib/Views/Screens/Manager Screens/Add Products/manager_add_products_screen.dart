import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerAddProductsScreen extends StatefulWidget {
  const ManagerAddProductsScreen({super.key});

  @override
  State<ManagerAddProductsScreen> createState() =>
      _ManagerAddProductsScreenState();
}

class _ManagerAddProductsScreenState extends State<ManagerAddProductsScreen> {
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  var productCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
                    'Add New Product',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
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
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: AppColors.green,
                      )),
                ),
                SizedBox(height: 20),
                textField(
                    hint: 'Name',
                    icon: Icons.fastfood,
                    controller: productNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product name required';
                      }
                      return null;
                    }),
                textField(
                    hint: 'Category',
                    icon: Icons.grid_view,
                    controller: productCategoryController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product category required';
                      }
                      return null;
                    }),
                textField(
                    hint: 'Price',
                    icon: Icons.attach_money,
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product price required';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                UniversalButton(
                    buttonWidth: 250,
                    title: 'Add Product',
                    ontap: () {
                      if (_formKey.currentState!.validate()) {}
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
}
