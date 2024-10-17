import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class AdminDeleteAccountScreen extends StatefulWidget {
  const AdminDeleteAccountScreen({super.key});

  @override
  State<AdminDeleteAccountScreen> createState() =>
      _AdminCreateNewAccountScreenState();
}

class _AdminCreateNewAccountScreenState
    extends State<AdminDeleteAccountScreen> {
  var _searchUserController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> predefinedUsernames = [
    'user1',
    'user2',
    'user3',
    'user4',
    'admin',
    'testuser',
    'example',
  ];
  List<String> filteredUsernames = [];
  bool isUserNameSelected = false;

  @override
  void initState() {
    super.initState();
    filteredUsernames = predefinedUsernames;
  }

  void _filterUsernames(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsernames = predefinedUsernames;
      });
    } else {
      setState(() {
        filteredUsernames = predefinedUsernames
            .where((username) =>
                username.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
        title: Text(
          'Delete Account',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightWhiteBackground,
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
                    'Account Deletion',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Permanently remove a user account and all associated data from the system.',
                    style: AppTextStyles.belowMainHeadingTextStyle(
                        fontSize: 15, textColor: AppColors.red.shade400),
                  ),
                ),
                SizedBox(height: 30),
                textField(
                    hint: 'Search Username...',
                    icon: Icons.person,
                    controller: _searchUserController,
                    keyboardType: TextInputType.name,
                    onChanged: _filterUsernames,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select a user.';
                      }
                      return null;
                    }),
                SizedBox(height: 10),
                // Show filtered usernames in a dropdown-like manner
                if (filteredUsernames.isNotEmpty &&
                    _searchUserController.text.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: filteredUsernames.map((username) {
                        return ListTile(
                          title: Text(username),
                          onTap: () {
                            _searchUserController.text = username;
                            setState(() {
                              filteredUsernames = [];
                              isUserNameSelected = true;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 20),
                Visibility(
                  visible: isUserNameSelected,
                  child: UniversalButton(
                      buttonWidth: 250,
                      title: 'Delete',
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
                                        'Confirm Deletion?',
                                        style: AppTextStyles
                                            .nameHeadingTextStyle(),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Are you sure you want to delete this user\'s account.',
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
                                              buttonColor: AppColors.green
                                                  .withOpacity(.7),
                                              ontap: () {
                                                Navigator.pop(context);

                                                customSnackbar(context,
                                                    'Account deleted.');
                                              }),
                                          UniversalButton(
                                              title: 'Cancel',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
                                              buttonColor:
                                                  AppColors.red.shade300,
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
                ),
                // SizedBox(height: 20),
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
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
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
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
