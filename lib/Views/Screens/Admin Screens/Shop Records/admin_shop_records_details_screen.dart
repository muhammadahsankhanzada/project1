import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';

class AdminShopRecordsDetailsScreen extends StatefulWidget {
  final String shopName;
  final String shopAddress;
  const AdminShopRecordsDetailsScreen({
    super.key,
    required this.shopName,
    required this.shopAddress,
  });

  @override
  State<AdminShopRecordsDetailsScreen> createState() =>
      _AdminShopRecordsDetailsScreenState();
}

class _AdminShopRecordsDetailsScreenState
    extends State<AdminShopRecordsDetailsScreen> {
  List<bool> isContainerClicked = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> storeDetails = {
      'Location': 'Shah Faisal Colony, Karachi',
      'Deliveries': '33',
      'Revenue': '50,000',
      'Type': 'General Store',
      'Timings': '8 AM to 10 PM',
      'Contact': '0302-8382845',
      'Email': 'info@communitystore.com',
      'Rating': 4.5,
    };

    //////////////////////////
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
        title: Text(
          widget.shopName,
          style: AppTextStyles.simpleHeadingTextStyle(
            textColor: AppColors.universalButtonGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightWhiteBackground,
      ),
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
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'General Store',
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
                              'A community-focused retail establishment located in the heart of the neighborhood, offering a diverse selection of groceries, household supplies, and personal care items, catering to all your daily needs.',
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
            for (int i = 0; i < 5; i++)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: InkWell(
                      onTap: () {
                        isContainerClicked[i] = !isContainerClicked[i];
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          // border: Border(
                          //   top: BorderSide(color: AppColors.lightGrey),
                          //   bottom: BorderSide(color: AppColors.lightGrey),
                          //   right: BorderSide(color: AppColors.lightGrey),
                          // ),
                          // borderRadius: BorderRadius.only(
                          //   topRight: Radius.circular(35),
                          //   bottomRight: Radius.circular(35),
                          // ),
                          color: isContainerClicked[i]
                              ? AppColors.lightGreen1.withOpacity(.3)
                              : AppColors.lightWhiteBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '6th Oct 2024',
                                        style: AppTextStyles
                                            .belowMainHeadingTextStyle(),
                                      ),
                                      Text(
                                        'Products Requested: 30',
                                        style: AppTextStyles
                                            .belowMainHeadingTextStyle(
                                                fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                              child: isContainerClicked[i]
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
                                                    CrossAxisAlignment.start,
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var value
                                                      in storeDetails.values)
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        value.toString(),
                                                        style: AppTextStyles
                                                            .belowMainHeadingTextStyle(
                                                                fontSize: 15),
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
              ),
          ],
        ),
      ),
    );
  }
}
