import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_details_screen.dart';

class ManagerApprovedRequestsScreen extends StatelessWidget {
  const ManagerApprovedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Approved Requests',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
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
                                  ManagerApprovedRequestsDetailsScreen()));
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      // margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.lightGrey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(Constants.logoImage),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahsan Store',
                                style:
                                    AppTextStyles.belowMainHeadingTextStyle(),
                              ),
                              Text(
                                'Shah Faisal, Karachi',
                                style: AppTextStyles.belowMainHeadingTextStyle(
                                    fontSize: 12),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Requested Products: 30',
                                style: AppTextStyles.belowMainHeadingTextStyle(
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
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 10),
                                  child: Icon(
                                    Icons.done_all,
                                    color: AppColors.green,
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
                  SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
