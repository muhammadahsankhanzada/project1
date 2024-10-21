import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Accounts%20Management/admin_new_password_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminPasswordResetRequestsScreen extends StatelessWidget {
  const AdminPasswordResetRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Password Reset Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                for (int i = 0; i < 3; i++)
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminNewPasswordScreen()));
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            // margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage(Constants.myImage),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Muhammad Ahsan',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 18),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Password Requested: ',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles
                                              .simpleHeadingTextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '2 days ago',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles
                                              .simpleHeadingTextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Expanded(
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.end,
                                //     children: [
                                //       Padding(
                                //         padding: const EdgeInsets.only(
                                //             top: 20, right: 10),
                                //         child: Icon(
                                //           Icons.done_all,
                                //           size: 30,
                                //           color: AppColors.green,
                                //         ),
                                //       ),
                                //       // SizedBox(height: 20),
                                //       // Text(
                                //       //   'Amount recieved: 3000',
                                //       //   style: AppTextStyles.belowMainHeadingTextStyle(
                                //       //       fontSize: 12),
                                //       // ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
