import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/admin_create_new_account_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class AdminCreateNewAccountScreen extends StatefulWidget {
  const AdminCreateNewAccountScreen({super.key});

  @override
  State<AdminCreateNewAccountScreen> createState() =>
      _AdminCreateNewAccountScreenState();
}

class _AdminCreateNewAccountScreenState
    extends State<AdminCreateNewAccountScreen> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _routeController = TextEditingController();
  var _ageController = TextEditingController();
  var _cnicController = TextEditingController();
  var _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(
        title: 'Create Account',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer<AdminCreateNewAccountViewModel>(
              builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add New User',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Add a new user by completing the required fields.',
                      style:
                          AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 30),
                  //Role DropDown
                  _buildCustomDropDownButton(
                    icon: Icons.people,
                    hint: 'Select a Role...',
                    currentSelectedValue: value.selectedRoleValue,
                    dropDownValuesList: value.roleValuesList,
                    onChanged: (String? newSelectedValue) {
                      value.selectedRoleValue = newSelectedValue;
                      if (newSelectedValue != null) {
                        value.updateRoleDropDownValue(newSelectedValue);
                      }
                    },
                  ),

                  SizedBox(height: 20),

                  Visibility(
                    visible: value.selectedRoleValue != null,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: AppColors.black,
                              )),
                        ),
                        SizedBox(height: 20),
                        _buildTextFieldWidget(
                            hint: 'Name',
                            icon: Icons.person_outline,
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            }),
                        Visibility(
                            visible: value.selectedRoleValue == 'Salesman',
                            child: Column(
                              children: [
                                _buildCustomDropDownButton(
                                  icon: Icons.car_rental,
                                  hint: 'Vehicle',
                                  currentSelectedValue:
                                      value.selectedVehicleValue,
                                  dropDownValuesList: value.vehicleValuesList,
                                  onChanged: (String? newSelectedValue) {
                                    value.selectedVehicleValue =
                                        newSelectedValue;
                                    if (newSelectedValue != null) {
                                      value.updateVehicleDropDownValue(
                                          newSelectedValue);
                                    }
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            )),
                        Visibility(
                            visible: value.selectedRoleValue == 'Manager',
                            child: Column(
                              children: [
                                _buildCustomDropDownButton(
                                  icon: Icons.store,
                                  hint: 'Warehouse',
                                  currentSelectedValue:
                                      value.selectedWarehouseValue,
                                  dropDownValuesList: value.warehouseValuesList,
                                  onChanged: (String? newSelectedValue) {
                                    value.selectedWarehouseValue =
                                        newSelectedValue;
                                    if (newSelectedValue != null) {
                                      value.updateWarehouseDropDownValue(
                                          newSelectedValue);
                                    }
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            )),
                        Visibility(
                          visible: value.selectedRoleValue != 'Salesman',
                          child: _buildTextFieldWidget(
                              hint: 'Email',
                              icon: Icons.email_outlined,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              }),
                        ),
                        _buildTextFieldWidget(
                            hint: 'Phone number',
                            icon: Icons.phone_outlined,
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              return null;
                            }),
                        _buildTextFieldWidget(
                            hint: 'Password',
                            icon: Icons.lock_outline,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            }),
                        _buildTextFieldWidget(
                            hint: 'Confirm password',
                            icon: Icons.lock_outline,
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            }),
                        Visibility(
                          visible: value.selectedRoleValue == 'Salesman',
                          child: _buildTextFieldWidget(
                              hint: 'Route',
                              icon: Icons.route,
                              controller: _routeController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Route is required';
                                }
                                return null;
                              }),
                        ),
                        _buildTextFieldWidget(
                            hint: 'Age (in years)',
                            icon: Icons.cake,
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Age is required';
                              }
                              return null;
                            }),
                        _buildTextFieldWidget(
                            hint: 'CNIC',
                            icon: Icons.info,
                            controller: _cnicController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CNIC is required';
                              }
                              return null;
                            }),
                        _buildTextFieldWidget(
                            hint: 'Address',
                            icon: Icons.location_on,
                            controller: _addressController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        UniversalButton(
                            buttonWidth: 250,
                            title: 'Create',
                            ontap: () {
                              if (_formKey.currentState!.validate()) {}
                              if (value.selectedRoleValue == 'Salesman') {
                                customSnackbar(context,
                                    'Salesman account successfully created');
                              }
                              if (value.selectedRoleValue == 'Manager') {
                                customSnackbar(context,
                                    'Manager account successfully created');
                              }
                              if (value.selectedRoleValue == 'Admin') {
                                customSnackbar(context,
                                    'Admin account successfully created');
                              }
                            }),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // Textfield for data
  Widget _buildTextFieldWidget({
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

  // Dropdown for selecting user role
  Widget _buildCustomDropDownButton({
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
