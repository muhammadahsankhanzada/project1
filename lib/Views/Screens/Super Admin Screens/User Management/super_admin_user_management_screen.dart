import 'package:flutter/material.dart';
import 'package:project1/Models/driver_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';

class SuperAdminUserManagementScreen extends StatelessWidget {
  const SuperAdminUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'User Management',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainer(
                  ontap: () {},
                  title: 'Create Account',
                ),
                SizedBox(width: 15),
                customContainer(
                  ontap: () {},
                  borderColor: AppColors.red,
                  title: 'Delete Account',
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Drivers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Managers'),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Admins'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: driversListContents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             AdminManagerRecordsDetailsScreen()));
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.white.withOpacity(.7),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.myImage),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                driversListContents[index].name,
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Address: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      driversListContents[index]
                                                          .address),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.assessment,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    })),
          ],
        ),
      ),
    );
  }

  //
  customContainer({
    required VoidCallback ontap,
    required String title,
    Color borderColor = AppColors.green,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.nameHeadingTextStyle(size: 15),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
