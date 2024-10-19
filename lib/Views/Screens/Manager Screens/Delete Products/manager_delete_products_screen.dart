import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
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
  final List<String> categoryValuesList = [
    'Electronics',
    'Home Appliances',
    'Fashion'
  ];
  String? selectedProductValue;
  final List<String> productValuesList = [
    'Laptop',
    'Smart Phone',
    'Camera',
    'Tablet',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
        title: Text(
          'Delete Products',
          style: AppTextStyles.simpleHeadingTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: AppColors.universalButtonGreen,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightWhiteBackground,
      ),
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
                    setState(() {});
                    print(selectedCategoryValue);
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
}
