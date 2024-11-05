import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagerApprovedRequestsScreen extends StatelessWidget {
  const ManagerApprovedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Approved Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            StreamBuilder(
                stream: fetchApprovedRequests(),
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
                      child: Text('No Approved Requests Found'),
                    );
                  } else if (snapshot.hasData) {
                    final approvedRequests = snapshot.data?.docs ?? [];
                    return Expanded(
                      child: ListView.builder(
                          itemCount: approvedRequests.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManagerApprovedRequestsDetailsScreen(
                                                  salesmanId:
                                                      approvedRequests[index]
                                                          .id,
                                                  salesmanName:
                                                      approvedRequests[index]
                                                          ['name'],
                                                )));
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Material(
                                    elevation: 3,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      // margin: EdgeInsets.only(bottom: 10),
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
                                            // backgroundImage: AssetImage(
                                            //     'assets/images/p1.jpeg'),
                                            child: ClipOval(
                                              child: Image.network(
                                                approvedRequests[index]
                                                    ['imageUrl'],
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                                errorBuilder: (context, error,
                                                    StackTrace) {
                                                  return Image.asset(
                                                    ImageUrls.errorImage,
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
                                                approvedRequests[index]['name'],
                                                style: AppTextStyles
                                                    .belowMainHeadingTextStyle(
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                'Route: ${approvedRequests[index]['route']}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Requested Products: ${approvedRequests[index]['productsRequested']}',
                                                style: AppTextStyles
                                                    .simpleHeadingTextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, right: 10),
                                                  child: Icon(
                                                    Icons.done_all,
                                                    size: 30,
                                                    color: AppColors.green,
                                                  ),
                                                ),
                                                // SizedBox(height: 20),
                                                // Text(
                                                //   'Amount recieved: 3000',
                                                //   style: AppTextStyles.belowMainHeadingTextStyle(
                                                //       fontSize: 12),
                                                // ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          }),
                    );
                  } else {
                    return Text('Loading...');
                  }
                }),
          ],
        ),
      ),
    );
  }

  // Method to get approved requests list
  Stream<QuerySnapshot> fetchApprovedRequests() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc('Ahsan')
        .collection('Approved Requests')
        .snapshots();
    return data;
  }
}
