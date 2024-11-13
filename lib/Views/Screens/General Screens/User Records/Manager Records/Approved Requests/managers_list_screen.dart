import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/manager_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagersListScreen extends StatefulWidget {
  const ManagersListScreen({super.key});

  @override
  State<ManagersListScreen> createState() => _ManagersListScreenState();
}

class _ManagersListScreenState extends State<ManagersListScreen> {
  var _searchController = TextEditingController();
  String searchedText = '';

  void _onChanged(String value) {
    setState(() {
      searchedText = value.toLowerCase();
    });
  }
  // List<ManagerListDummyModel> filteredManagersList = managersListContents;
  // List<ManagerListDummyModel> allManagersList = managersListContents;
  // void _filterManagers(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       filteredManagersList = allManagersList;
  //     });
  //   } else {
  //     setState(() {
  //       filteredManagersList = allManagersList
  //           .where((manager) =>
  //               manager.name.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Manager Records'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              onChanged: _onChanged,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search manager name...',
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: StreamBuilder(
                    stream: fetchManagersList(),
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
                          child: Text('No Records Found'),
                        );
                      } else if (snapshot.hasData) {
                        var managers = snapshot.data?.docs ?? [];
                        final filteredManagers = managers.where((manager) {
                          final managerName =
                              (manager['name'] ?? '').toLowerCase();
                          return managerName.contains(searchedText);
                        }).toList();
                        return ListView.builder(
                            itemCount: filteredManagers.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ManagerRecordsDetailsScreen(
                                                    managerName:
                                                        filteredManagers[index]
                                                            ['name'],
                                                  )));
                                    },
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: AppColors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            // backgroundImage: AssetImage(
                                            //     'assets/images/p3.jpeg'),
                                            child: ClipOval(
                                              child: Image.network(
                                                filteredManagers[index]
                                                    ['imageUrl'],
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                      ImageUrls.errorImage);
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        filteredManagers[index]
                                                            ['name'],
                                                        style: AppTextStyles
                                                            .nameHeadingTextStyle(
                                                                size: 15),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Address: ',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 150,
                                                          child: Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              filteredManagers[
                                                                      index]
                                                                  ['address']),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.assessment,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                    })),
          ],
        ),
      ),
    );
  }

  // Method to fetch salesmen list
  Stream<QuerySnapshot> fetchManagersList() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore
        .collection('Users')
        .doc('Staff')
        .collection('Managers')
        .snapshots();
    return data;
  }
}
