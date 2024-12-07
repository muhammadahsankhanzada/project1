import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/tables_data.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_cart_details_view_model.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/Shop%20Final%20Order%20Summary/salesman_store_cart_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_bottom_nav_bar_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class SalesmanCartDetailsScreen extends StatefulWidget {
  final VoidCallback startTripButtonTapped;
  const SalesmanCartDetailsScreen({
    super.key,
    required this.startTripButtonTapped,
  });

  @override
  State<SalesmanCartDetailsScreen> createState() =>
      _SalesmanCartDetailsScreenState();
}

class _SalesmanCartDetailsScreenState extends State<SalesmanCartDetailsScreen> {
  bool isRequestButtonClicked = false;
  bool isRequestApproved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Your Order Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: isRequestButtonClicked
                    ? Lottie.asset(
                        !isRequestApproved
                            ? 'assets/animations/waiting.json'
                            : 'assets/animations/approved.json',
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      )
                    : SizedBox(),
              ),
              Align(
                alignment: Alignment.center,
                child: isRequestButtonClicked
                    ? Text(
                        !isRequestApproved
                            ? 'Waiting for Approval...'
                            : 'Request Approved',
                        style:
                            AppTextStyles.simpleHeadingTextStyle(fontSize: 20),
                      )
                    : SizedBox(),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen1.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items',
                          style: AppTextStyles.nameHeadingTextStyle(),
                        ),
                        Text(
                          'Quantity',
                          style: AppTextStyles.nameHeadingTextStyle(),
                        ),
                        Text(
                          'Price',
                          style: AppTextStyles.nameHeadingTextStyle(),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.black,
                    ),
                    FutureBuilderHelperWidget(
                      future: context
                          .read<SalesmanCartDetailsViewModel>()
                          .fetchCartItems(),
                      onSuccess: (products) {
                        return ListView.builder(
                            itemCount: products.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      product[TablesData
                                          .salesmanCartTable.productName],
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      'x${product[TablesData.salesmanCartTable.productQuantity]}',
                                      style:
                                          AppTextStyles.nameHeadingTextStyle(),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      'Rs. ${(product[TablesData.salesmanCartTable.productPrice] * product[TablesData.salesmanCartTable.productQuantity]).toStringAsFixed(0)}',
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      loadingWidget: CircularProgressIndicator(),
                      emptyWidget: Text('Cart is empty'),
                      errorWidget: Text('Error getting cart items'),
                    ),
                    SizedBox(height: 30),
                    Divider(
                      color: AppColors.black,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Items',
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 18),
                        ),
                        Spacer(),
                        FutureBuilderHelperWidget(
                            future: context
                                .read<SalesmanCartDetailsViewModel>()
                                .fetchCartItems(),
                            onSuccess: (products) {
                              return Text(
                                products.length.toString(),
                                style: AppTextStyles.nameHeadingTextStyle(
                                    size: 18),
                              );
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 16),
                        ),
                        Spacer(),
                        FutureBuilderHelperWidget(
                            future: context
                                .read<SalesmanCartDetailsViewModel>()
                                .getTotalPrice(),
                            onSuccess: (totalPrice) {
                              return Text(
                                'Rs. ${totalPrice.toStringAsFixed(0)}/-',
                                // '5000',
                                style: AppTextStyles.nameHeadingTextStyle(
                                    size: 16),
                              );
                            }),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isRequestButtonClicked && !isRequestApproved,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: UniversalButton(
                          title: 'Cancel Request',
                          buttonColor: AppColors.red.withOpacity(.7),
                          ontap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SalesmanBottomNavBarScreen()));
                          }),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              // SizedBox(height: 10),
              if (isRequestApproved)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        UniversalButton(
                          buttonWidth: 150,
                          title: 'Start trip',
                          buttonColor: AppColors.universalButtonGreen,
                          ontap: () {
                            // var sp = await SharedPreferences.getInstance();
                            // sp.setBool('tripStarted', false);

                            widget.startTripButtonTapped();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SalesmanStoreCartScreen(
                                          itemsSelected: false,
                                          goToShopsTab:
                                              widget.startTripButtonTapped,
                                        )));
                          },
                        ),
                        UniversalButton(
                            buttonWidth: 150,
                            title: 'Cancel',
                            ontap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SalesmanBottomNavBarScreen()));
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: !isRequestButtonClicked,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          UniversalButton(
                              title: 'Proceed',
                              buttonWidth: 150,
                              buttonColor: AppColors.universalButtonGreen,
                              ontap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                          height: 200,
                                          width: 300,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: AppColors.popupBackground,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 20),
                                              Text(
                                                'Request Order',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: AppColors.white,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Are you sure you want to request these items?',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                  fontSize: 18,
                                                  textColor: AppColors.white,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Material(
                                                    elevation: 4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: UniversalButton(
                                                        title: 'Confirm',
                                                        buttonHeight: 40,
                                                        buttonWidth: 110,
                                                        buttonColor: AppColors
                                                            .universalButtonGreen,
                                                        ontap: () {
                                                          isRequestButtonClicked =
                                                              true;
                                                          //////////////////
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 7),
                                                              () {
                                                            isRequestApproved =
                                                                true;
                                                            setState(() {});
                                                          });

                                                          // Navigator.pushReplacement(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             DriverSummaryScreen()));
                                                        }),
                                                  ),
                                                  Material(
                                                    elevation: 4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: UniversalButton(
                                                        title: 'Cancel',
                                                        buttonHeight: 40,
                                                        buttonWidth: 110,
                                                        ontap: () {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                          UniversalButton(
                              title: 'Cancel',
                              buttonWidth: 150,
                              ontap: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
