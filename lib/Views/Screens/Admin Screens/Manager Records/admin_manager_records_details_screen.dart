import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Manager%20Records/Rejected%20Requests/admin_manager_rejected_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_requests_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminManagerRecordsDetailsScreen extends StatefulWidget {
  final String managerName;
  const AdminManagerRecordsDetailsScreen({
    super.key,
    required this.managerName,
  });

  @override
  State<AdminManagerRecordsDetailsScreen> createState() =>
      _AdminManagerRecordsDetailsScreenState();
}

class _AdminManagerRecordsDetailsScreenState
    extends State<AdminManagerRecordsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Manager Info'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: StreamBuilder(
              stream: fetchManagerRecords(),
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
                    child: Text('Record not Found'),
                  );
                } else if (snapshot.hasData) {
                  var manager = snapshot.data?.data() as Map<String, dynamic>?;
                  Map<String, dynamic> driverDetails = {
                    'Warehouse': 'Warehouse 01',
                    'CNIC': '45402-6789012-3',
                    'Phone Number': '0304-1234567',
                    'Address': manager?['address'],
                    'Email': 'ahsan@gmail.com',
                    'Password': '12345',
                    'Age': 24,
                    'Requests Approved': '30',
                    'Requests Rejected': '10',
                  };

                  return Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: Image.network(
                            manager?['imageUrl'],
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(Constants.errorImage);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.managerName,
                            style: AppTextStyles.nameHeadingTextStyle(size: 15),
                          ),
                          Text(
                            'Warehouse Manager',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen1.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var key in driverDetails.keys)
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
                                for (var value in driverDetails.values)
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      value.toString(),
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 15),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManagerApprovedRequestsScreen()));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              // color: AppColors.green,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Approved Requests',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManagerPendingRequestsScreen()));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              // color: AppColors.grey,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Pending Requests',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdminManagerRejectedRequestsScreen()));
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              // color: AppColors.red,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Rejected Requests',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 16),
                            ),
                          ),
                        ),
                      ),
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

  // Method to fetch manager records
  Stream<DocumentSnapshot> fetchManagerRecords() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .doc(widget.managerName)
        .snapshots();
    return data;
  }
}
