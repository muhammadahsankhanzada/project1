import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_request_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagerPendingRequestsScreen extends StatelessWidget {
  const ManagerPendingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Pending Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                  stream: fetchPendingRequests(),
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
                        child: Text('No Pending Requests Found'),
                      );
                    } else if (snapshot.hasData) {
                      final pendingRequests = snapshot.data?.docs ?? [];
                      return ListView.builder(
                          itemCount: pendingRequests.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManagerPendingRequestDetailsScreen(
                                                  salesmanId:
                                                      pendingRequests[index].id,
                                                )));
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: AppColors.containerBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            child: ClipOval(
                                              child: Image.network(
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                                pendingRequests[index]
                                                    ['imageUrl'],
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    Constants.errorImage,
                                                    fit: BoxFit.cover,
                                                    width: 70,
                                                    height: 70,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                pendingRequests[index]['name'],
                                                style: AppTextStyles
                                                    .belowMainHeadingTextStyle(
                                                        fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  'Route: ${pendingRequests[index]['route']}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .simpleHeadingTextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Requested Products: ${pendingRequests[index]['productsRequested']}',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                  }),
            ),
            // for (int i = 0; i < 3; i++)
            // Column(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     ManagerPendingRequestDetailsScreen()));
            //       },
            //       borderRadius: BorderRadius.circular(10),
            //       child: Material(
            //         elevation: 3,
            //         borderRadius: BorderRadius.circular(10),
            //         child: Container(
            //           padding: EdgeInsets.all(15),
            //           // margin: EdgeInsets.only(bottom: 10),
            //           decoration: BoxDecoration(
            //             color: AppColors.containerBackground,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               CircleAvatar(
            //                 radius: 35,
            //                 backgroundImage:
            //                     AssetImage('assets/images/p2.jpeg'),
            //               ),
            //               SizedBox(width: 10),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'Muhammad Ahsan',
            //                     style:
            //                         AppTextStyles.belowMainHeadingTextStyle(
            //                             fontSize: 18),
            //                   ),
            //                   SizedBox(
            //                     width: 200,
            //                     child: Text(
            //                       'Route: Shah Faisal, Karachi',
            //                       maxLines: 2,
            //                       overflow: TextOverflow.ellipsis,
            //                       style: AppTextStyles.simpleHeadingTextStyle(
            //                         fontSize: 15,
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(height: 10),
            //                   Text(
            //                     'Requested Products: 30',
            //                     style: AppTextStyles.simpleHeadingTextStyle(
            //                       fontSize: 15,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(height: 10),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  // Method to get pending requests list
  Stream<QuerySnapshot> fetchPendingRequests() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc('Ahsan')
        .collection('Pending Requests')
        .snapshots();
    return data;
  }
}
