import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminEditProductsScreen extends StatefulWidget {
  const SuperAdminEditProductsScreen({super.key});

  @override
  State<SuperAdminEditProductsScreen> createState() =>
      _SuperAdminEditProductsScreenState();
}

class _SuperAdminEditProductsScreenState
    extends State<SuperAdminEditProductsScreen> {
  var _formKey = GlobalKey<FormState>();
  var _categoryController = TextEditingController();
  var _productController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Edit Products',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
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
                textField(
                    hint: 'Select category',
                    icon: Icons.grid_view,
                    controller: _categoryController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product category is required';
                      }
                      return null;
                    }),
                textField(
                    hint: 'Select product',
                    icon: Icons.fastfood,
                    controller: _productController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product name is required';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                UniversalButton(
                    buttonWidth: 250,
                    title: 'Save',
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
}
