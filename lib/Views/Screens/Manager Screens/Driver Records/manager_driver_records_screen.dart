import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/driver_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Driver%20Records/manager_driver_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class ManagerDriverRecordsScreen extends StatefulWidget {
  const ManagerDriverRecordsScreen({super.key});

  @override
  State<ManagerDriverRecordsScreen> createState() =>
      _ManagerDriverRecordsScreenState();
}

class _ManagerDriverRecordsScreenState
    extends State<ManagerDriverRecordsScreen> {
  var _searchController = TextEditingController();
  List<DriversListModel> filteredDriversList = driversListContents;
  List<DriversListModel> allDriversList = driversListContents;
  void _filterDrivers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredDriversList = allDriversList;
      });
    } else {
      setState(() {
        filteredDriversList = allDriversList
            .where((driver) =>
                driver.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Driver Records'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              onChanged: _filterDrivers,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search driver name...',
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
                child: ListView.builder(
                    itemCount: filteredDriversList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerDriverRecordsDetailsScreen(
                                            driverName:
                                                filteredDriversList[index].name,
                                            driverRoute:
                                                filteredDriversList[index]
                                                    .address,
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
                                    backgroundImage:
                                        AssetImage(Constants.myImage),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                filteredDriversList[index].name,
                                                style: AppTextStyles
                                                    .nameHeadingTextStyle(
                                                        size: 15),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Route: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      filteredDriversList[index]
                                                          .address),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Icon(
                                        //   Icons.assessment,
                                        // )
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
                    })),
          ],
        ),
      ),
    );
  }
}
