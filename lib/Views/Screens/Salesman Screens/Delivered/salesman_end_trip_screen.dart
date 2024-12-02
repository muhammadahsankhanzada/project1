import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Delivered/salesman_deliverd_orders_summary_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SalesmanEndTripScreen extends StatelessWidget {
  const SalesmanEndTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Checkout List'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today\'s Orders',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 15),
            _buildShowOrdersList(context),
          ],
        ),
      ),
    );
  }

  // Show orders list
  Widget _buildShowOrdersList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 13,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SalesmanDeliverdOrdersSummaryScreen()));
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                      ),
                      color: AppColors.lightGreen1.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ahsan Store',
                              style: AppTextStyles.belowMainHeadingTextStyle(),
                            ),
                            Text(
                              'Shah Faisal, Karachi',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 12),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Products delivered: 30',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.done_all,
                                color: AppColors.green,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Amount recieved: 3000',
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            );
          }),
    );
  }
}
