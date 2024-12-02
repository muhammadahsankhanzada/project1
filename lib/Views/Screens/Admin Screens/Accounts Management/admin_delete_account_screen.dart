import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/delete_account_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/search_box_widget.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class AdminDeleteAccountScreen extends StatefulWidget {
  const AdminDeleteAccountScreen({super.key});

  @override
  State<AdminDeleteAccountScreen> createState() =>
      _AdminCreateNewAccountScreenState();
}

class _AdminCreateNewAccountScreenState
    extends State<AdminDeleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  var _searchUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Delete Account'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer<DeleteAccountViewModel>(
              builder: (context, value, child) {
            return Form(
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
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.circular(value.isSearching ? 15 : 30),
                    ),
                    child: Column(
                      children: [
                        SearchBoxWidget(
                          controller: _searchUserController,
                          hintText: 'Enter Email / Phone Number',
                          keyboardType: TextInputType.name,
                          onChanged: value.onChanged,
                        ),
                        AnimatedSize(
                          duration: Duration(milliseconds: 500),
                          child: Visibility(
                            visible: value.isSearching,
                            child: Column(
                              children: [
                                Divider(
                                  color: AppColors.grey,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                _buildUserAccountsListWidget(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: value.isUserNameSelected,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(value.selectedUserImage),
                          ),
                          Text(
                            value.selectedUserName,
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Contact:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Email:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.selectedUserAddress,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      value.selectedUserContact,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      value.selectedUserEmail,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: value.isUserNameSelected,
                    child: UniversalButton(
                        buttonWidth: 250,
                        title: 'Delete Account',
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildUserAccountsListWidget() {
    return Consumer<DeleteAccountViewModel>(builder: (context, value, child) {
      return StreamBuilderHelperWidget(
        stream: value.fetchUserRecords(),
        onSuccess: (result) {
          var data = result.docs;

          final filteredUsers = value.filterUsernames(data);

          return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    value.selectedUserName = filteredUsers[index]['name'];
                    value.selectedUserImage = filteredUsers[index]['imageUrl'];
                    value.selectedUserAddress = filteredUsers[index]['address'];
                    value.selectedUserContact = '030238928223';
                    value.selectedUserEmail = 'asfdf@gmail.com';
                    _searchUserController.text = '';
                    value.isUserNameSelected = true;
                    value.isSearching = false;
                  },
                  leading: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        filteredUsers[index]['imageUrl'],
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(ImageUrls.errorImage);
                        },
                      ),
                    ),
                  ),
                  title: Text(filteredUsers[index]['name'].toString()),
                  subtitle: Text(filteredUsers[index]['address']),
                );
              });
        },
        loadingWidget: CircularProgressIndicator(),
        errorWidget: Text('Error Fetching Records'),
        emptyWidget: Text('No Records Found'),
      );
    });
  }
}
