import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerAddProductsScreen extends StatefulWidget {
  final List<String> warehouseList;
  const ManagerAddProductsScreen({
    super.key,
    required this.warehouseList,
  });

  @override
  State<ManagerAddProductsScreen> createState() =>
      _ManagerAddProductsScreenState();
}

class _ManagerAddProductsScreenState extends State<ManagerAddProductsScreen> {
  var _productNameController = TextEditingController();
  var _productPriceController = TextEditingController();
  var _productQuantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedCategoryValue;
  final List<String> categoryValues = [
    'Electronics',
    'Home Appliances',
    'Fashion'
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Row(
                        children: [
                          Icon(
                            Icons.grid_view,
                            color: AppColors.green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Select Category',
                            style: AppTextStyles.nameHeadingTextStyle(size: 15),
                          ),
                        ],
                      ),
                      value: selectedCategoryValue,
                      onChanged: (String? newCategoryValue) {
                        selectedCategoryValue = newCategoryValue;
                        setState(() {});
                        print(selectedCategoryValue);
                      },
                      items: categoryValues
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  color: AppColors.green,
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
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
