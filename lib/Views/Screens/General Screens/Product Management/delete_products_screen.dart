import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_products_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class DeleteProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const DeleteProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<DeleteProductsScreen> createState() => _DeleteProductsScreenState();
}

class _DeleteProductsScreenState extends State<DeleteProductsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var warehouse in widget.warehouseList) {
      print(warehouse);
    }
    final viewModel =
        Provider.of<DeleteProductsViewModel>(context, listen: false);
    viewModel.showCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: CustomAppbar(title: 'Delete Product'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Consumer<DeleteProductsViewModel>(
                builder: (context, value, child) {
              return Column(
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
                  _buildCustomDropDown(
                    icon: Icons.grid_view,
                    hint: 'Select Category',
                    currentSelectedValue: value.selectedCategoryValue,
                    dropDownValuesList: value.categoryValuesList,
                    onChanged: value.updateSelectedCategory,
                  ),
                  SizedBox(height: 20),

                  //Product DropDown
                  Visibility(
                    visible: value.selectedCategoryValue != null,
                    child: Column(
                      children: [
                        _buildCustomDropDown(
                          icon: Icons.fastfood,
                          hint: 'Select Product',
                          currentSelectedValue: value.selectedProductValue,
                          dropDownValuesList: value.productValuesList,
                          onChanged: value.updateSelectedProduct,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  UniversalButton(
                      buttonWidth: 250,
                      title: 'Delete Product',
                      ontap: () {
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
                                        style: AppTextStyles
                                            .nameHeadingTextStyle(),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Are you sure you want to delete this product?',
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
                                              buttonColor: AppColors
                                                  .universalButtonGreen,
                                              ontap: () {
                                                value.deleteProduct(
                                                    value.selectedProductValue!,
                                                    context);
                                              }),
                                          UniversalButton(
                                              title: 'Cancel',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
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
              );
            }),
          ),
        ),
      ),
    );
  }

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
        borderRadius: BorderRadius.circular(10),
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
