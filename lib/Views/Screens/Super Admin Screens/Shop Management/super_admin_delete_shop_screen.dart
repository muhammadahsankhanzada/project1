import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminDeleteShopScreen extends StatefulWidget {
  const SuperAdminDeleteShopScreen({super.key});

  @override
  State<SuperAdminDeleteShopScreen> createState() =>
      _SuperAdminDeleteShopScreenState();
}

class _SuperAdminDeleteShopScreenState
    extends State<SuperAdminDeleteShopScreen> {
  final _formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Delete Shop',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Delete a Shop',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Are you sure you want to delete this shop?\nThis action cannot be undone..',
                    style: AppTextStyles.belowMainHeadingTextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                textField(
                    hint: 'Search shop...',
                    icon: Icons.search,
                    controller: _searchController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select a shop from the list';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name),
                SizedBox(height: 20),
                UniversalButton(
                    buttonWidth: 250,
                    title: 'Delete Shop',
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
                                      'Delete Shop?',
                                      style:
                                          AppTextStyles.nameHeadingTextStyle(),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Are you sure you want to delete.\nAll associated data will be deleted.',
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
                                                  context, 'Shop deleted.');
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

  // Custom Textfield
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
