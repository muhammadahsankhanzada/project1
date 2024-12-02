import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/shop_records_details_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ShopRecordsDetailsScreen extends StatefulWidget {
  final String shopName,
      shopAddress,
      shopImage,
      shopIntro,
      shopType,
      shopTimings,
      shopContact,
      shopEmail;
  const ShopRecordsDetailsScreen({
    super.key,
    required this.shopName,
    required this.shopAddress,
    required this.shopImage,
    required this.shopIntro,
    required this.shopType,
    required this.shopTimings,
    required this.shopContact,
    required this.shopEmail,
  });

  @override
  State<ShopRecordsDetailsScreen> createState() =>
      _ShopRecordsDetailsScreenState();
}

class _ShopRecordsDetailsScreenState extends State<ShopRecordsDetailsScreen> {
  @override
  void initState() {
    // Reset screen state
    Future.microtask(() {
      context.read<ShopRecordsDetailsViewModel>().resetState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: widget.shopName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildShowShopDetails(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Orders Completed',
                  style: AppTextStyles.nameHeadingTextStyle(size: 18),
                ),
              ),
            ),
            SizedBox(height: 15),
            _buildShowCompletedOrders(),
          ],
        ),
      ),
    );
  }

  // Show shop details
  Widget _buildShowShopDetails() {
    return FutureBuilderHelperWidget(
      future: context
          .read<ShopRecordsDetailsViewModel>()
          .fetchShopRecords(widget.shopName),
      onSuccess: (result) {
        final shop = result.data() as Map<String, dynamic>;
        final storeDetails =
            context.read<ShopRecordsDetailsViewModel>().showShopDetails(shop);

        return Column(
          children: [
            Row(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 30, left: 15, right: 20, bottom: 30),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen1.withOpacity(.3),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                            ),
                            SizedBox(width: 10),
                            Text(
                              shop['type'],
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 20),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 320,
                            child: Text(
                              maxLines: 5,
                              shop['intro'],
                              textAlign: TextAlign.justify,
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var key in storeDetails.keys)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${key}:',
                                style: AppTextStyles.nameHeadingTextStyle(
                                    size: 15),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var value in storeDetails.values)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                value.toString(),
                                style: AppTextStyles.belowMainHeadingTextStyle(
                                    fontSize: 15),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
        );
      },
      loadingWidget: _buildDetailsLoading(),
      emptyWidget: Text('No Records Found'),
      errorWidget: Text('Error Getting Records'),
    );
  }

  // Show shop details
  Widget _buildShowCompletedOrders() {
    return FutureBuilderHelperWidget(
      future: context
          .read<ShopRecordsDetailsViewModel>()
          .fetchCompletedOrders(widget.shopName),
      onSuccess: (result) {
        final completedOrders = result.docs;

        Map<String, dynamic> storeDetails = {
          'Location': widget.shopAddress,
          'Deliveries': '33',
          'Revenue': '50,000',
          'Type': widget.shopType,
          'Timings': widget.shopTimings,
          'Contact': widget.shopContact,
          'Email': widget.shopEmail,
          'Rating': 4.5,
        };

        return completedOrders.isEmpty
            ? Center(
                child: Text(
                '0 Orders Completed',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
            : Consumer<ShopRecordsDetailsViewModel>(
                builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: completedOrders.length,
                  itemBuilder: (context, index) {
                    final orders = completedOrders[index];
                    final orderDate = orders['date'] ?? 'N/A';
                    final orderRequestedProducts =
                        orders['requestedProducts'] ?? 'N/A';
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: InkWell(
                            onTap: () {
                              value.toggleContainerClick(index);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                color: value.isContainerClicked[index]
                                    ? AppColors.lightGreen1.withOpacity(.3)
                                    : AppColors.lightWhiteBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              orderDate,
                                              style: AppTextStyles
                                                  .belowMainHeadingTextStyle(),
                                            ),
                                            Text(
                                              'Requested Products: ${orderRequestedProducts.toString()}',
                                              style: AppTextStyles
                                                  .belowMainHeadingTextStyle(
                                                      fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.done_all,
                                              color: AppColors.green,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    child: value.isContainerClicked[index]
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Column(children: [
                                              SizedBox(height: 20),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (var key
                                                            in storeDetails
                                                                .keys)
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              '${key}:',
                                                              style: AppTextStyles
                                                                  .nameHeadingTextStyle(
                                                                      size: 15),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 20),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (var value
                                                            in storeDetails
                                                                .values)
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              value.toString(),
                                                              style: AppTextStyles
                                                                  .belowMainHeadingTextStyle(
                                                                      fontSize:
                                                                          15),
                                                            ),
                                                          ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    );
                  },
                );
              });
      },
      loadingWidget: CircularProgressIndicator(),
      emptyWidget: Text('No Orders Found'),
      errorWidget: Text('Error Getting Completed Orders'),
    );
  }

  // Shop details loading
  Widget _buildDetailsLoading() {
    return Shimmer.fromColors(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ]),
          ),
        ],
      ),
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
    );
  }
}
