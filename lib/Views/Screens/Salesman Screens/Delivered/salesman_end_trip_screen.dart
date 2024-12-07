import 'package:flutter/material.dart';
import 'package:project1/Models/salesman_trips_list_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_end_trip_view_model.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Delivered/salesman_deliverd_orders_summary_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';

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
    return FutureBuilderHelperWidget<List<SalesmanTripsListModel>>(
      future: context.read<SalesmanEndTripViewModel>().fetchSalesmanTrips(),
      onSuccess: (trips) {
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
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
                                  trip.shopName,
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(),
                                ),
                                Text(
                                  trip.route,
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(
                                          fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Products delivered: ${trip.productsDelivered.toString()}',
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(
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
                                  'Amount recieved: ${trip.amountRecieved.toString()}',
                                  style:
                                      AppTextStyles.belowMainHeadingTextStyle(
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
      },
      loadingWidget: CircularProgressIndicator(),
      emptyWidget: Text('No Trips Found'),
      errorWidget: Text('Error Loading Trips'),
    );
  }
}
