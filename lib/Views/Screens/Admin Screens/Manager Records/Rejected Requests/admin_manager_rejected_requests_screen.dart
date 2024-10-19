import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Manager%20Records/Rejected%20Requests/admin_manager_rejected_requests_details_screen.dart';

class AdminManagerRejectedRequestsScreen extends StatelessWidget {
  const AdminManagerRejectedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Text(
            'Rejected Requests',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.universalButtonGreen,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightWhiteBackground),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
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
                                  AdminManagerRejectedRequestsDetailsScreen()));
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
                              radius: 35,
                              backgroundImage: AssetImage(Constants.myImage),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Muhammad Ahsan',
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Route: ',
                                      style: AppTextStyles.nameHeadingTextStyle(
                                          size: 12),
                                    ),
                                    Text(
                                      'Shah Faisal, Karachi',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Requested Products: 30',
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(
                                          fontSize: 12),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 10),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  // SizedBox(height: 20),
                                  // Text(
                                  //   'Amount recieved: 3000',
                                  //   style: AppTextStyles.belowMainHeadingTextStyle(
                                  //       fontSize: 12),
                                  // ),
                                ],
                              ),
                            )
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
      ),
    );
  }
}
