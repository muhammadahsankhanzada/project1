import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:project1/Models/warehouse_model.dart';

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
  File? _pickedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Warehouse'),
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
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      _pickedImage = File(pickedFile.path);
                      setState(() {});
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: _pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                fit: BoxFit.fill,
                                _pickedImage!,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: AppColors.black,
                            )),
                ),
                SizedBox(height: 20),
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                textField(
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
                        addWarehouse(
                          id: _nameController.text,
                          nameController: _nameController.text,
                          addressController: _addressController.text,
                          managerNameController: _managerNameController.text,
                          contactController: _contactController.text.toString(),
                          emailController: _emailController.text,
                          totalEmployeesController:
                              _totalEmployeesController.text.toString(),
                          storageCapacityController:
                              _storageCapacityController.text,
                          loadingDocksController:
                              _loadingDocksController.text.toString(),
                          entriesController: _entriesController.text.toString(),
                          spaceAvailableController:
                              _spaceAvailableController.text,
                        );
                      }
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
                color: AppColors.black,
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

  // Method to upload image to firebase storage and get imageUrl
  Future<void> uploadImage() async {
    if (_pickedImage == null) return;
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('shops_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(_pickedImage!);
      print('Picked image: $_pickedImage');
      // Get the download URL
      _imageUrl = await ref.getDownloadURL();
      print(_imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  addWarehouse({
    required String id,
    required String nameController,
    required String addressController,
    required String managerNameController,
    required String contactController,
    required String emailController,
    required String totalEmployeesController,
    required String storageCapacityController,
    required String loadingDocksController,
    required String entriesController,
    required String spaceAvailableController,
  }) async {
    await uploadImage();
    print(_pickedImage);
    print(_imageUrl);
    if (nameController.isNotEmpty &&
        addressController.isNotEmpty &&
        managerNameController.isNotEmpty &&
        contactController.isNotEmpty &&
        emailController.isNotEmpty &&
        totalEmployeesController.isNotEmpty &&
        storageCapacityController.isNotEmpty &&
        loadingDocksController.isNotEmpty &&
        entriesController.isNotEmpty &&
        spaceAvailableController.isNotEmpty &&
        _imageUrl != null) {
      Warehouse newWarehouse = Warehouse(
        id: id,
        name: nameController,
        imageUrl: _imageUrl!,
        address: addressController,
        managerName: managerNameController,
        contact: contactController,
        email: emailController,
        totalEmployees: totalEmployeesController,
        storageCapacity: storageCapacityController,
        loadingDocks: loadingDocksController,
        entries: entriesController,
        spaceAvailable: spaceAvailableController,
      );

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('Warehouses')
          .doc(newWarehouse.id)
          .set(newWarehouse.toMap())
          .then((_) {
        print('Warehouse added with id: ${newWarehouse.id}');
      }).catchError((error) {
        print('Error adding: $error');
      });
    } else {
      customSnackbar(context, 'Please fill all fields');
    }
  }
}
