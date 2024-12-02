import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/add_products_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class AddProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const AddProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  var _productNameController = TextEditingController();
  var _productPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();
  var _productNewCategoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var warehouse in widget.warehouseList) {
      print(warehouse);
    }
    // Fetch Categories List
    final viewModel = Provider.of<AddProductsViewModel>(context, listen: false);
    viewModel.showCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Product'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Consumer<AddProductsViewModel>(builder: (context, value, child) {
            return Form(
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
                      'Enter the product details.',
                      style:
                          AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      value.pickImageOntap();
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: value.pickedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  fit: BoxFit.fill,
                                  value.pickedImage!,
                                ),
                              )
                            : Icon(
                                Icons.camera_alt,
                                size: 35,
                              )),
                  ),
                  SizedBox(height: 20),
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10),
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
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ],
                        ),
                        value: value.selectedCategoryValue,
                        onChanged: value.changeSelectedCategory,
                        items: [
                          ...value.categoryValuesList
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
                    visible: value.selectedCategoryValue == 'Other',
                    child: _buildCustomTextField(
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
                  SizedBox(height: 10),
                  UniversalButton(
                      buttonWidth: 250,
                      title: 'Add New Product',
                      ontap: () async {
                        if (_formKey.currentState!.validate() &&
                            value.selectedCategoryValue != null) {
                          value.addProduct(
                            context: context,
                            productNameController: _productNameController.text,
                            productPriceController:
                                _productPriceController.text.toString(),
                            productQuantityController:
                                _productQuantityController.text.toString(),
                            productNewCategoryNameController:
                                _productNewCategoryNameController.text,
                            warehouseList: widget.warehouseList,
                          );
                        } else {
                          customSnackbar(context, 'Please fill all fields');
                        }
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
                color: AppColors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
