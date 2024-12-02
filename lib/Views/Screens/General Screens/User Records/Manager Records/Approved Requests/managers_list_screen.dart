import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/managers_list_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/manager_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagersListScreen extends StatefulWidget {
  const ManagersListScreen({super.key});

  @override
  State<ManagersListScreen> createState() => _ManagersListScreenState();
}

class _ManagersListScreenState extends State<ManagersListScreen> {
  var _searchController = TextEditingController();

  @override
  void initState() {
    // Reset screen state
    Future.microtask(() {
      context.read<ManagersListViewModel>().resetState();
    });
    super.initState();
  }

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
            Consumer<ManagersListViewModel>(builder: (context, value, child) {
              return TextFormField(
                controller: _searchController,
                onChanged: value.onChanged,
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
              );
            }),
            SizedBox(height: 20),
            _buildSteamBuilder(),
          ],
        ),
      ),
    );
  }

  // To search, filter and show managers list
  Widget _buildSteamBuilder() {
    return Consumer<ManagersListViewModel>(builder: (context, value, child) {
      return StreamBuilderHelperWidget<QuerySnapshot>(
          stream: value.managersStream,
          onSuccess: (result) {
            final filteredManagers = value.getFilteredManagersList(result.docs);

            return Expanded(
              child: filteredManagers.isEmpty
                  ? Center(
                      child: Text(
                      'No Managers Found',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  : ListView.builder(
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
                                      child: ClipOval(
                                        child: Image.network(
                                          filteredManagers[index]['imageUrl'],
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        filteredManagers[index]
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
                      }),
            );
          },
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('No Managers Found.'),
          errorWidget: Text('Error Searching Managers'));
    });
  }
}
