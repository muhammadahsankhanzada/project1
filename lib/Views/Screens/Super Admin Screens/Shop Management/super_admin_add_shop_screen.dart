import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Models/shops_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminAddShopScreen extends StatefulWidget {
  const SuperAdminAddShopScreen({super.key});

  @override
  State<SuperAdminAddShopScreen> createState() =>
      _SuperAdminAddShopScreenState();
}

class _SuperAdminAddShopScreenState extends State<SuperAdminAddShopScreen> {
  var _nameController = TextEditingController();
  var _introController = TextEditingController();
  var _typeController = TextEditingController();
  var _addressController = TextEditingController();
  var _timingsController = TextEditingController();
  var _contactController = TextEditingController();
  var _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Add Shop'),
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
                    'Add a new Shop',
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
                        return 'Provide a name for the shop (e.g. Famous Foods)';
                      }
                      return null;
                    }),
                textField(
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
                textField(
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
                        addShop(
                          id: _nameController.text,
                          nameController: _nameController.text,
                          introController: _introController.text,
                          typeController: _typeController.text,
                          addressController: _addressController.text,
                          timingsController: _timingsController.text,
                          contactController: _contactController.text,
                          emailController: _emailController.text,
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

  // Upload image to firebase storage and get imageUrl
  Future<void> uploadImage() async {
    if (_pickedImage == null) return;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('shops_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      await ref.putFile(_pickedImage!);
      print('Picimage: $_pickedImage');
      // Get the download URL
      _imageUrl = await ref.getDownloadURL();
      print(_imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  addShop({
    required String id,
    required String nameController,
    required String introController,
    required String typeController,
    required String addressController,
    required String timingsController,
    required String contactController,
    required String emailController,
  }) async {
    await uploadImage();
    print(_pickedImage);
    print(_imageUrl);
    if (nameController.isNotEmpty &&
        introController.isNotEmpty &&
        typeController.isNotEmpty &&
        addressController.isNotEmpty &&
        timingsController.isNotEmpty &&
        contactController.isNotEmpty &&
        emailController.isNotEmpty &&
        _imageUrl != null) {
      Shop newShop = Shop(
        id: id,
        name: nameController,
        imageUrl: _imageUrl!,
        intro: introController,
        type: typeController,
        address: addressController,
        timings: timingsController,
        contact: contactController,
        email: emailController,
      );

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore
          .collection('Shops')
          .doc(newShop.id)
          .set(newShop.toMap())
          .then((_) {
        print('Shop added with id: ${newShop.id}');
      }).catchError((error) {
        print('Error adding: $error');
      });
    } else {
      customSnackbar(context, 'Please fill all fields');
    }
  }
}
