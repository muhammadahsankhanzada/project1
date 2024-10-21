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
  void initState() {
    super.initState();
    for (var warehouse in widget.warehouseList) {
      print(warehouse);
    }
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
