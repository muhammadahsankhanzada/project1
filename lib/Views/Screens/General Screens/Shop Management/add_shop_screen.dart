import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/add_shop_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class AddShopScreen extends StatefulWidget {
  const AddShopScreen({super.key});

  @override
  State<AddShopScreen> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  var _nameController = TextEditingController();
  var _introController = TextEditingController();
  var _typeController = TextEditingController();
  var _addressController = TextEditingController();
  var _timingsController = TextEditingController();
  var _contactController = TextEditingController();
  var _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Shop'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer<AddShopViewModel>(builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add New Shop',
                      style: AppTextStyles.nameHeadingTextStyle(size: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter the shop details.',
                      style:
                          AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      value.pickImageOnTap();
                    },
                    borderRadius: BorderRadius.circular(10),
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
                                size: 40,
                                color: AppColors.black,
                              )),
                  ),
                  SizedBox(height: 20),
                  _buildCustomTextField(
                      hint: 'Name',
                      icon: Icons.store,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a name for the shop (e.g. Famous Foods)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Intro',
                      icon: Icons.play_arrow,
                      controller: _introController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a short intro';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Type',
                      icon: Icons.text_fields,
                      controller: _typeController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a shop type (e.g. General Store)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Address',
                      icon: Icons.location_on,
                      controller: _addressController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide address';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Timings',
                      icon: Icons.access_time,
                      controller: _timingsController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide shop open timings (e.g. 8AM to 10PM)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Contact',
                      icon: Icons.phone,
                      controller: _contactController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a phone number (e.g. 0304-2638473)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Email',
                      icon: Icons.email,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email (e.g. famousfoods@abc.com)';
                        }
                        return null;
                      }),
                  SizedBox(height: 10),
                  UniversalButton(
                      buttonWidth: 250,
                      title: 'Add Shop',
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          value.addShop(
                            id: _nameController.text,
                            nameController: _nameController.text,
                            introController: _introController.text,
                            typeController: _typeController.text,
                            addressController: _addressController.text,
                            timingsController: _timingsController.text,
                            contactController: _contactController.text,
                            emailController: _emailController.text,
                            context: context,
                          );
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
