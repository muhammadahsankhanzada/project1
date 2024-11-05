import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

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
          child: StreamBuilder(
              stream: fetchPendingRequestSummary(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Data Found'),
                  );
                } else if (snapshot.hasData) {
                  final products = snapshot.data?.docs ?? [];
                  // Calculating total amount
                  totalAmount = 0;
                  for (var product in products) {
                    totalAmount += int.parse(product['price'].toString());
                  }
                  return Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                  DateTime dateTime =
                                      products[index]['dateTime'].toDate();
                                  String formattedDate =
                                      DateFormat('dd MMM, hh:mm a')
                                          .format(dateTime);
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                products[index]['name'],
                                                // 'Iphone 15 pro max',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                        fontSize: 14),
                                              ),
                                              Text(
                                                products[index]['new']
                                                    ? 'New'
                                                    : 'Old',
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
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
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.remove_circle,
                                                      size: 15,
                                                    ),
                                                    Text(products[index]
                                                            ['quantity']
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                  totalAmount.toString(),
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
                } else {
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              }),
        ),
      ),
    );
  }

  // Method to get pending request summary
  Stream<QuerySnapshot> fetchPendingRequestSummary() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc('Ahsan')
        .collection('Pending Requests')
        .doc(widget.salesmanId)
        .collection('Requested Products')
        .snapshots();
    return data;
  }

  // Future<void> moveData(String sourceDocId, String targetDocId) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   // Reference to the source document
  //   DocumentReference sourceDoc = firestore
  //       .collection('Users')
  //       .doc('Staff')
  //       .collection('Managers')
  //       .doc('Ahsan')
  //       .collection('Pending Requests')
  //       .doc(sourceDocId);

  //   try {
  //     // Fetch the data from the source document
  //     DocumentSnapshot snapshot = await sourceDoc.get();
  //     if (snapshot.exists) {
  //       // Get the data you want to move
  //       Map<String, dynamic> dataToMove =
  //           snapshot.data() as Map<String, dynamic>;

  //       // Reference to the target document (or create a new one)
  //       DocumentReference targetDoc = firestore
  //           .collection('Users')
  //           .doc('Staff')
  //           .collection('Managers')
  //           .doc('Ahsan')
  //           .collection('Approved Requests')
  //           .doc(targetDocId);

  //       // Add data to the target document
  //       await targetDoc.set(dataToMove,
  //           SetOptions(merge: true)); // Use merge to keep existing data

  //       // Delete the source document after moving the data
  //       // await sourceDoc.delete();

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Data moved successfully!')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Source document not found!')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error moving data: $e')),
  //     );
  //   }
  // }
}
