import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';

class AdminManagerRecordsScreen extends StatefulWidget {
  const AdminManagerRecordsScreen({super.key});

  @override
  State<AdminManagerRecordsScreen> createState() =>
      _AdminManagerRecordsScreenState();
}

class _AdminManagerRecordsScreenState extends State<AdminManagerRecordsScreen> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Manager Records',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search manager name...',
                hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    Icons.search,
                    color: AppColors.green,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ManagerDriverRecordsDetailsScreen()));
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.white.withOpacity(.7),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.logoImage),
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
                                            Text(
                                              'Muhammad Ahsan',
                                              style: AppTextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 15),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Address: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text('Shah Faisal Colony'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.assessment,
                                        )
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