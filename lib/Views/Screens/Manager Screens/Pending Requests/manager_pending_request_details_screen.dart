import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_pending_requests_details_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class ManagerPendingRequestDetailsScreen extends StatefulWidget {
  final salesmanId;
  const ManagerPendingRequestDetailsScreen(
      {super.key, required this.salesmanId});

  @override
  State<ManagerPendingRequestDetailsScreen> createState() =>
      _ManagerPendingRequestDetailsScreenState();
}

class _ManagerPendingRequestDetailsScreenState
    extends State<ManagerPendingRequestDetailsScreen> {
  int totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Request Summary'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: _buildShowRequestSummary(),
        ),
      ),
    );
  }

  // Show request summary
  Widget _buildShowRequestSummary() {
    return Consumer<ManagerPendingRequestsDetailsViewModel>(
        builder: (context, value, child) {
      return FutureBuilderHelperWidget(
        future: value.fetchPendingRequestSummary(widget.salesmanId),
        onSuccess: (products) {
          // final products = result.docs;

          // Calculating total amount
          totalAmount = 0;
          for (var product in products) {
            totalAmount += int.parse(product['price'].toString());
          }
          return Column(
            children: [
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightGreen1.withOpacity(.3)),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          // Formatting date time of product addition
                          Timestamp timestamp = Timestamp(
                              products[index]['dateTime']['_seconds'],
                              products[index]['dateTime']['_nanoseconds']);
                          DateTime dateTime = timestamp.toDate();
                          String formattedDate =
                              DateFormat('dd MMM, hh:mm a').format(dateTime);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                      products[index]['imageUrl'],
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          ImageUrls.errorImage,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index]['name'],
                                        // 'Iphone 15 pro max',
                                        style: AppTextStyles
                                            .simpleHeadingTextStyle(
                                                fontSize: 14),
                                      ),
                                      Text(
                                        products[index]['new'] ? 'New' : 'Old',
                                        style:
                                            AppTextStyles.nameHeadingTextStyle(
                                          size: 13,
                                        ),
                                      ),
                                      Text(
                                        formattedDate,
                                        // '29Nov, 01:20 pm',
                                        style: AppTextStyles
                                            .simpleHeadingTextStyle(
                                                fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.remove_circle,
                                              size: 15,
                                            ),
                                            Text(products[index]['quantity']
                                                .toString()),
                                            Icon(
                                              Icons.add_circle,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Rs. ${products[index]['price']}/-',
                                          style: AppTextStyles
                                              .belowMainHeadingTextStyle(
                                                  fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppColors.lightGreen1,
                              )
                            ],
                          );
                        }),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Orders',
                          style: AppTextStyles.simpleHeadingTextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          products.length.toString(),
                          style: AppTextStyles.simpleHeadingTextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTextStyles.nameHeadingTextStyle(),
                        ),
                        Text(
                          'Rs. ${totalAmount.toString()}/-',
                          style: AppTextStyles.simpleHeadingTextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UniversalButton(
                    title: 'Approve',
                    buttonColor: AppColors.universalButtonGreen,
                    buttonWidth: 150,
                    ontap: () {
                      // moveData(widget.salesmanId, widget.salesmanId);
                      customSnackbar(context, 'Request Approved');
                    },
                  ),
                  UniversalButton(
                    title: 'Disapprove',
                    buttonWidth: 150,
                    ontap: () {
                      customSnackbar(context, 'Request Disapproved');
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('Request Summary Not Found'),
        errorWidget: Text('Error Getting Request Summary'),
      );
    });
  }
}
