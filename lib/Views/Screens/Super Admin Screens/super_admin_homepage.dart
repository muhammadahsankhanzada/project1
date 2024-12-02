import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Models/super_admin_home_screen_screens_data_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Super%20Admin%20View%20Models/super_admin_home_view_model.dart';
import 'package:project1/Views/Widgets/search_box_widget.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SuperAdminHomepage extends StatefulWidget {
  const SuperAdminHomepage({super.key});

  @override
  State<SuperAdminHomepage> createState() => _SuperAdminHomepageState();
}

class _SuperAdminHomepageState extends State<SuperAdminHomepage> {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(ImageUrls.myImage),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Super Admin',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.grid_view,
                      size: 18,
                      color: AppColors.universalButtonGreen,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Dashboard',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.lightWhiteBackground),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Consumer<SuperAdminHomeViewModel>(
                builder: (context, value, child) {
              return SearchBoxWidget(
                controller: _searchController,
                hintText: 'Search',
                keyboardType: TextInputType.name,
                onChanged: value.onChanged,
              );
            }),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Overview',
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Dashboard reports dropdown
                          Consumer<SuperAdminHomeViewModel>(
                            builder: (context, value, child) {
                              return _buildReportsDropDownButton(
                                currentSelectedValue:
                                    value.selectedReportsValue,
                                dropDownValuesList: value.reportValuesList,
                                onChanged: (String? newSelectedValue) {
                                  value.selectedReportsValue = newSelectedValue;
                                  if (newSelectedValue != null) {
                                    value.updateReportSelection(
                                        newSelectedValue);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Dashboard reports
                    Consumer<SuperAdminHomeViewModel>(
                        builder: (context, value, child) {
                      return StreamBuilderHelperWidget<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: value.fetchDashboardReports(),
                        onSuccess: (data) {
                          var dashboardData =
                              data.data() as Map<String, dynamic>;
                          var reportsInfoContainerData = [
                            {
                              'title': 'Total Sales',
                              'value': dashboardData['sales'],
                              'percentage': dashboardData['salesPercentage'],
                            },
                            {
                              'title': 'Total Orders',
                              'value': dashboardData['orders'],
                              'percentage': dashboardData['ordersPercentage'],
                            },
                            {
                              'title': 'Available Stock',
                              'value': dashboardData['stock'],
                              'percentage': dashboardData['stockPercentage'],
                            },
                            {
                              'title': 'Pending Orders',
                              'value': dashboardData['pendingOrders'],
                              'percentage':
                                  dashboardData['pendingOrdersPercentage'],
                            },
                          ];
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2.2,
                            ),
                            itemCount: reportsInfoContainerData.length,
                            itemBuilder: (context, index) {
                              final report = reportsInfoContainerData[index];
                              return _buildReportsInfoContainer(
                                report['title'],
                                report['value'],
                                '+${report['percentage']}%',
                              );
                            },
                          );
                        },
                        loadingWidget: _buildDashboardReportsLoading(),
                        errorWidget: Text('Error loading data'),
                        emptyWidget: Text('No reports available'),
                      );
                    }),
                    SizedBox(height: 10),
                    ...superAdminScreensDataModelContents.map((data) {
                      return _buildGoToDifferentScreensButton(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => data.screen));
                          },
                          title: data.title,
                          icon: data.icon);
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // For go to different screens button
  Widget _buildGoToDifferentScreensButton(
      {required VoidCallback ontap,
      required String title,
      required IconData icon}) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(15),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.loginBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontSize: 15,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(width: 30),
                  // Icon(
                  //   icon,
                  //   color: AppColors.green,
                  // ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // For showing dashboard reports
  Widget _buildReportsInfoContainer(String title, value, percentage) {
    return Container(
      width: 180,
      padding: EdgeInsets.only(left: 20, top: 20, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 13,
            ),
          ),
          Row(
            children: [
              Text(
                value.toString(),
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20),
              Text(
                percentage.toString(),
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // For monthly, weekly and yearly dropdown button
  _buildReportsDropDownButton({
    required String? currentSelectedValue,
    required List<String> dropDownValuesList,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 35,
      width: 110,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentSelectedValue,
          onChanged: onChanged,
          items:
              dropDownValuesList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      value,
                      style: AppTextStyles.simpleHeadingTextStyle(fontSize: 15),
                    ),
                  ],
                ));
          }).toList(),
        ),
      ),
    );
  }

  // Dashboard reports loading
  Widget _buildDashboardReportsLoading() {
    return Shimmer.fromColors(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              width: 180,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }
}
