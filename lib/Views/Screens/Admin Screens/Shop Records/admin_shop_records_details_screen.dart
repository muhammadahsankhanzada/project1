import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminShopRecordsDetailsScreen extends StatefulWidget {
  final String shopName,
      shopAddress,
      shopImage,
      shopIntro,
      shopType,
      shopTimings,
      shopContact,
      shopEmail;
  const AdminShopRecordsDetailsScreen({
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
  State<AdminShopRecordsDetailsScreen> createState() =>
      _AdminShopRecordsDetailsScreenState();
}

class _AdminShopRecordsDetailsScreenState
    extends State<AdminShopRecordsDetailsScreen> {
  List<bool> isContainerClicked = List.generate(2, (index) => false);

  @override
  void initState() {
    super.initState();
    // fetchCompletedOrdersDetails();
  }

  @override
  Widget build(BuildContext context) {
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

    //////////////////////////
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: widget.shopName),
      body: SingleChildScrollView(
        child: Column(
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
                    // margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen1.withOpacity(.3),
                      // gradient: LinearGradient(
                      //     begin: Alignment.topCenter,
                      //     end: Alignment.bottomCenter,
                      //     colors: [
                      //       AppColors.lightGreen,
                      //       AppColors.white.withOpacity(.5),
                      //     ]),
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
                              widget.shopType,
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
                              widget.shopIntro,
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
                    // color: AppColors.white.withOpacity(.7),
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
            completedOrders(),
            // for (int i = 0; i < 5; i++)
            //   Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(right: 20, left: 20),
            //         child: InkWell(
            //           onTap: () {
            //             isContainerClicked[i] = !isContainerClicked[i];
            //             setState(() {});
            //           },
            //           borderRadius: BorderRadius.circular(20),
            //           child: AnimatedContainer(
            //             duration: Duration(milliseconds: 300),
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            //             decoration: BoxDecoration(
            //               // border: Border(
            //               //   top: BorderSide(color: AppColors.lightGrey),
            //               //   bottom: BorderSide(color: AppColors.lightGrey),
            //               //   right: BorderSide(color: AppColors.lightGrey),
            //               // ),
            //               // borderRadius: BorderRadius.only(
            //               //   topRight: Radius.circular(35),
            //               //   bottomRight: Radius.circular(35),
            //               // ),
            //               color: isContainerClicked[i]
            //                   ? AppColors.lightGreen1.withOpacity(.3)
            //                   : AppColors.lightWhiteBackground,
            //               borderRadius: BorderRadius.circular(20),
            //               border: Border.all(),
            //             ),
            //             child: Column(
            //               children: [
            //                 Padding(
            //                   padding:
            //                       const EdgeInsets.only(left: 15, right: 15),
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             '6th Oct 2024',
            //                             style: AppTextStyles
            //                                 .belowMainHeadingTextStyle(),
            //                           ),
            //                           Text(
            //                             'Products Requested: 30',
            //                             style: AppTextStyles
            //                                 .belowMainHeadingTextStyle(
            //                                     fontSize: 12),
            //                           ),
            //                         ],
            //                       ),
            //                       Column(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: [
            //                           Icon(
            //                             Icons.done_all,
            //                             color: AppColors.green,
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 AnimatedSize(
            //                   duration: Duration(milliseconds: 300),
            //                   child: isContainerClicked[i]
            //                       ? Padding(
            //                           padding: const EdgeInsets.symmetric(
            //                               horizontal: 5),
            //                           child: Column(children: [
            //                             SizedBox(height: 20),
            //                             Container(
            //                               padding: EdgeInsets.all(10),
            //                               decoration: BoxDecoration(
            //                                 // color: AppColors.white.withOpacity(.7),
            //                                 borderRadius:
            //                                     BorderRadius.circular(10),
            //                               ),
            //                               child: Row(
            //                                 children: [
            //                                   Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       for (var key
            //                                           in storeDetails.keys)
            //                                         Align(
            //                                           alignment:
            //                                               Alignment.topLeft,
            //                                           child: Text(
            //                                             '${key}:',
            //                                             style: AppTextStyles
            //                                                 .nameHeadingTextStyle(
            //                                                     size: 15),
            //                                           ),
            //                                         ),
            //                                     ],
            //                                   ),
            //                                   SizedBox(width: 20),
            //                                   Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       for (var value
            //                                           in storeDetails.values)
            //                                         Align(
            //                                           alignment:
            //                                               Alignment.topLeft,
            //                                           child: Text(
            //                                             value.toString(),
            //                                             style: AppTextStyles
            //                                                 .belowMainHeadingTextStyle(
            //                                                     fontSize: 15),
            //                                           ),
            //                                         ),
            //                                     ],
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                           ]),
            //                         )
            //                       : SizedBox(),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(height: 15),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }

  // fetchCompletedOrdersDetails() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final snapshot = await firestore
  //       .collection('Shops')
  //       .doc(widget.shopName)
  //       .collection('Completed Orders')
  //       .get();
  //   snapshot.docs.forEach((doc) {
  //     print(doc.data()['date']);
  //   });
  // }

  // Completed Orders Showing Widget
  Widget completedOrders() {
    // Dummy Data
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

    CollectionReference firestore = FirebaseFirestore.instance
        .collection('Shops')
        .doc(widget.shopName)
        .collection('Completed Orders');

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No shops found.'));
        }

        final completedOrders = snapshot.data!.docs;

        return completedOrders.isEmpty
            ? Center(
                child: Text(
                '0 Orders Completed',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))
            : ListView.builder(
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
                            isContainerClicked[index] =
                                !isContainerClicked[index];
                            setState(() {});
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: isContainerClicked[index]
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
                                  child: isContainerClicked[index]
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(children: [
                                            SizedBox(height: 20),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                // color: AppColors.white.withOpacity(.7),
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
                                                          in storeDetails.keys)
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
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
                                                          alignment:
                                                              Alignment.topLeft,
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
      },
    );
  }
}
