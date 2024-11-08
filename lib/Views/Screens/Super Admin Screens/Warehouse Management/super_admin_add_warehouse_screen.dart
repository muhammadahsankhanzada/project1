import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/add_warehouse_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class SuperAdminAddWarehouseScreen extends StatefulWidget {
  const SuperAdminAddWarehouseScreen({super.key});

  @override
  State<SuperAdminAddWarehouseScreen> createState() =>
      _SuperAdminAddWarehouseScreenState();
}

class _SuperAdminAddWarehouseScreenState
    extends State<SuperAdminAddWarehouseScreen> {
  var _nameController = TextEditingController();
  var _addressController = TextEditingController();
  var _managerNameController = TextEditingController();
  var _contactController = TextEditingController();
  var _emailController = TextEditingController();
  var _totalEmployeesController = TextEditingController();
  var _storageCapacityController = TextEditingController();
  var _loadingDocksController = TextEditingController();
  var _entriesController = TextEditingController();
  var _spaceAvailableController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Warehouse'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              Consumer<AddWarehouseViewModel>(builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add New Warehouse',
                      style: AppTextStyles.nameHeadingTextStyle(size: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter the warehouse details.',
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
                          return 'Provide name of your Warehouse (e.g. Alpha Warehouse)';
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
                      hint: 'Manager name',
                      icon: Icons.people,
                      controller: _managerNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide warehouse manager name';
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
                          return 'Enter email address (e.g. famousfoods@abc.com)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Total Employees',
                      icon: Icons.people,
                      controller: _totalEmployeesController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter total employees';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Storage Capacity',
                      icon: Icons.storage,
                      controller: _storageCapacityController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter storage capacity (e.g. 500 pounds/sqf)';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Loading Docks',
                      icon: Icons.access_time,
                      controller: _loadingDocksController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter loading docs number';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Entries',
                      icon: Icons.door_front_door,
                      controller: _entriesController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide entry gates number';
                        }
                        return null;
                      }),
                  _buildCustomTextField(
                      hint: 'Space Available',
                      icon: Icons.access_time,
                      controller: _spaceAvailableController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide available space (e.g. 20000sf)';
                        }
                        return null;
                      }),
                  SizedBox(height: 10),
                  UniversalButton(
                      buttonWidth: 250,
                      title: 'Add Warehouse',
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          value.addWarehouse(
                            id: _nameController.text,
                            nameController: _nameController.text,
                            addressController: _addressController.text,
                            managerNameController: _managerNameController.text,
                            contactController:
                                _contactController.text.toString(),
                            emailController: _emailController.text,
                            totalEmployeesController:
                                _totalEmployeesController.text.toString(),
                            storageCapacityController:
                                _storageCapacityController.text,
                            loadingDocksController:
                                _loadingDocksController.text.toString(),
                            entriesController:
                                _entriesController.text.toString(),
                            spaceAvailableController:
                                _spaceAvailableController.text,
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
