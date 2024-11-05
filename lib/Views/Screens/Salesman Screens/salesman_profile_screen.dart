import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SalesmanProfileScreen extends StatefulWidget {
  final salesmanName;
  const SalesmanProfileScreen({super.key, required this.salesmanName});

  @override
  State<SalesmanProfileScreen> createState() => _SalesmanProfileScreenState();
}

class _SalesmanProfileScreenState extends State<SalesmanProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: ''),
      body: StreamBuilder(
          stream: fetchSalesmanDetails(),
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
              final salesman = snapshot.data?.data() as Map<String, dynamic>?;
              return Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 35,
                      child: ClipOval(
                        child: Image.network(
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          salesman?['imageUrl'],
                          errorBuilder: (context, error, stackTrace) {
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
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: [],
                      ),
                      Column(
                        children: [],
                      ),
                    ],
                  ),
                  salesmanDetailsContainer(values: [
                    salesman?['name'],
                    salesman!['cnic'].toString(),
                    '${salesman['age'].toString()} years',
                    salesman['address'],
                    salesman['route'],
                    '0${salesman['contact'].toString()}',
                    salesman['totalTrips'].toString(),
                  ]),
                  SizedBox(height: 10),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: AppColors.black,
                    thickness: 1.5,
                  ),
                  SizedBox(height: 20),
                  UniversalButton(
                      title: 'Logout',
                      ontap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                        customSnackbar(context, 'Logout Successful');
                      }),
                ],
              );
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          }),
    );
  }

  salesmanDetailsContainer({required List<String> values}) {
    List<String> keys = [
      'Name :',
      'CNIC :',
      'Age :',
      'Address :',
      'Route :',
      'Phone Number :',
      'Total Trips :',
    ];
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < keys.length; i++)
                      Text(
                        keys[i],
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < keys.length; i++)
                      Text(
                        values[i],
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to get salesman details
  Stream<DocumentSnapshot> fetchSalesmanDetails() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Salesmen')
        .doc(widget.salesmanName)
        .snapshots();
    return data;
  }
}
