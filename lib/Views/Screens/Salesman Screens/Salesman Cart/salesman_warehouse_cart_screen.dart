import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/tables_data.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_warehouse_cart_view_model.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/salesman_cart_details_screen.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class SalesmanWarehouseCartScreen extends StatefulWidget {
  final VoidCallback startTripButtonTapped;
  const SalesmanWarehouseCartScreen(
      {super.key, required this.startTripButtonTapped});

  @override
  State<SalesmanWarehouseCartScreen> createState() =>
      _SalesmanWarehouseCartScreenState();
}

class _SalesmanWarehouseCartScreenState
    extends State<SalesmanWarehouseCartScreen> {
  bool isRequestButtonClicked = false;
  bool isRequestApproved = false;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<SalesmanWarehouseCartViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Your Orders',
              style: AppTextStyles.simpleHeadingTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                textColor: AppColors.universalButtonGreen,
              ),
            ),
            SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightGreen1,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Active Orders',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontSize: 12,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                        color: AppColors.lightGreen1,
                      ),
                      SizedBox(height: 10),
                      FutureBuilderHelperWidget(
                        future: context
                            .read<SalesmanWarehouseCartViewModel>()
                            .fetchLocalCartItems(),
                        onSuccess: (products) {
                          return ListView.builder(
                              itemCount: products.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              '${TablesData.salesmanCartTable.productImage}',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  ImageUrls.errorImage,
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        product[
                                                            '${TablesData.salesmanCartTable.productName}'],
                                                        style: AppTextStyles
                                                            .simpleHeadingTextStyle(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        product[
                                                            '${TablesData.salesmanCartTable.productType}'],
                                                        style: AppTextStyles
                                                            .belowMainHeadingTextStyle(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        product[
                                                            '${TablesData.salesmanCartTable.dateTime}'],
                                                        style: AppTextStyles
                                                            .simpleHeadingTextStyle(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .lightGrey
                                                                .withOpacity(
                                                                    .3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              onPressed: () {
                                                                viewModel.decrementQuantity(
                                                                    productId: product[TablesData
                                                                        .salesmanCartTable
                                                                        .productId]);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                size: 20,
                                                              )),
                                                          Consumer<
                                                                  SalesmanWarehouseCartViewModel>(
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                            return Text(
                                                              product['${TablesData.salesmanCartTable.productQuantity}']
                                                                  .toString(),
                                                              style: AppTextStyles
                                                                  .nameHeadingTextStyle(
                                                                      size: 15),
                                                            );
                                                          }),
                                                          IconButton(
                                                              onPressed: () {
                                                                viewModel.incrementQuantity(
                                                                    productId: product[TablesData
                                                                        .salesmanCartTable
                                                                        .productId]);
                                                              },
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: Icon(
                                                                Icons
                                                                    .add_circle,
                                                                size: 20,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Consumer<
                                                              SalesmanWarehouseCartViewModel>(
                                                          builder: (context,
                                                              value, child) {
                                                        return Text(
                                                          textAlign:
                                                              TextAlign.end,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // 'Rs. ${(driverCartContents[index].price * driverCartContents[index].quantity).toStringAsFixed(0)}/-',
                                                          'Rs. ${(product['${TablesData.salesmanCartTable.productPrice}'] * product['${TablesData.salesmanCartTable.productQuantity}']).toStringAsFixed(0)}',
                                                          style: AppTextStyles
                                                              .simpleHeadingTextStyle(
                                                                  fontSize: 15),
                                                        );
                                                      }),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Consumer<
                                                            SalesmanWarehouseCartViewModel>(
                                                        builder: (context,
                                                            value, child) {
                                                      return Text(
                                                        textAlign:
                                                            TextAlign.end,
                                                        '${product['${TablesData.salesmanCartTable.productQuantity}']} item(s)',
                                                        style: AppTextStyles
                                                            .simpleHeadingTextStyle(
                                                                fontSize: 12),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Divider(
                                        thickness: 2,
                                        color: AppColors.lightGreen1,
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        loadingWidget: CircularProgressIndicator(),
                        emptyWidget: Text('Cart is empty'),
                        errorWidget: Text('Error getting cart items'),
                      ),
                      SizedBox(height: 10),
                      FutureBuilderHelperWidget(
                          future: context
                              .read<SalesmanWarehouseCartViewModel>()
                              .fetchLocalCartItems(),
                          onSuccess: (products) {
                            return products.length == 0
                                ? Text(
                                    'Cart is Empty',
                                    style: AppTextStyles
                                        .belowMainHeadingTextStyle(),
                                  )
                                : UniversalButton(
                                    title: 'Confirm',
                                    buttonColor: AppColors.universalButtonGreen,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SalesmanCartDetailsScreen(
                                                    startTripButtonTapped: widget
                                                        .startTripButtonTapped,
                                                  )));
                                    });
                          }),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
