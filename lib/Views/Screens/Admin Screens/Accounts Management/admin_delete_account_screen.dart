import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
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
      appBar: CustomAppbar(title: 'Delete Account'),
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
                TextFormField(
                  controller: _searchUserController,
                  onChanged: _filterUsernames,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Select a user';
                  //   }
                  //   return null;
                  // },
                  keyboardType: TextInputType.name,

                  decoration: InputDecoration(
                    hintText: 'Enter Email / Phone Number',
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

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
                                              title: 'Cancel',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
                                              buttonColor: AppColors.black,
                                              ontap: () {
                                                Navigator.pop(context);
                                              }),
                                          UniversalButton(
                                              title: 'Delete',
                                              buttonHeight: 40,
                                              buttonWidth: 110,
                                              buttonColor: AppColors.green,
                                              ontap: () {
                                                Navigator.pop(context);

                                                customSnackbar(context,
                                                    'Account deleted.');
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
}
