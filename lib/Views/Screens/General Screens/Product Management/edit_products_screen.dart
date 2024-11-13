import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/edit_products_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const EditProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  var _formKey = GlobalKey<FormState>();
  var _productNameController = TextEditingController();
  var _productPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var warehouse in widget.warehouseList) {
      print(warehouse);
    }
    final viewModel =
        Provider.of<EditProductsViewModel>(context, listen: false);
    viewModel.showCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Edit Products'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Consumer<EditProductsViewModel>(builder: (context, value, child) {
            return Form(
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
                  _buildCustomDropDown(
                    icon: Icons.grid_view,
                    hint: 'Select a Category',
                    currentSelectedValue: value.selectedCategoryValue,
                    dropDownValuesList: value.categoryValuesList,
                    onChanged: value.updateCategoryValue,
                  ),
                  SizedBox(height: 20),

                  //Product DropDown
                  Visibility(
                    visible: value.selectedCategoryValue != null,
                    child: Column(
                      children: [
                        _buildCustomDropDown(
                          icon: Icons.fastfood,
                          hint: 'Select a Product',
                          currentSelectedValue: value.selectedProductValue,
                          dropDownValuesList: value.productValuesList,
                          onChanged: value.updateProductValue,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: value.selectedProductValue != null,
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
                        _buildCustomTextField(
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
                        _buildCustomTextField(
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
                        _buildCustomTextField(
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
                        value.updateProduct(
                          productId: value.selectedProductValue!,
                          productNameController:
                              _productNameController.text.toString(),
                          productPriceController:
                              _productPriceController.text.toString(),
                          productQuantityController:
                              _productQuantityController.text.toString(),
                          context: context,
                        );
                      }),
                  SizedBox(height: 20),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // Textfield
  Widget _buildCustomTextField({
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

  // To show products
  Widget _buildCustomDropDown({
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
}
