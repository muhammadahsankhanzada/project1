import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_rejected_requests_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/Rejected%20Requests/manager_rejected_requests_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerRejectedRequestsScreen extends StatelessWidget {
  final managerName;
  const ManagerRejectedRequestsScreen({super.key, required this.managerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Rejected Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: _buildShowRejectedRequests(),
      ),
    );
  }

  // Stream to show rejected requests list
  Widget _buildShowRejectedRequests() {
    return Consumer<ManagerRejectedRequestsViewModel>(
        builder: (context, value, child) {
      return StreamBuilderHelperWidget(
        stream: value.fetchRejectedRequests(managerName),
        onSuccess: (result) {
          final rejectedRequests = result.docs;
          return ListView.builder(
              itemCount: rejectedRequests.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManagerRejectedRequestsDetailsScreen(
                                          salesmanId:
                                              rejectedRequests[index].id,
                                          salesmanName: rejectedRequests[index]
                                              ['name'],
                                        )));
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.containerBackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    child: ClipOval(
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                        rejectedRequests[index]['imageUrl'],
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                        rejectedRequests[index]['name'],
                                        style: AppTextStyles
                                            .belowMainHeadingTextStyle(),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Route: ',
                                            style: AppTextStyles
                                                .nameHeadingTextStyle(size: 12),
                                          ),
                                          Text(
                                            rejectedRequests[index]['route'],
                                            style: AppTextStyles
                                                .belowMainHeadingTextStyle(
                                                    fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Requested Products: ${rejectedRequests[index]['productsRequested']}',
                                        style: AppTextStyles
                                            .belowMainHeadingTextStyle(
                                                fontSize: 12),
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
                                          padding: const EdgeInsets.only(
                                              top: 20, right: 10),
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: AppColors.red,
                                          ),
                                        ),
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
                    ),
                  ],
                );
              });
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('No Pending Requests Found'),
        errorWidget: Text('Error Getting Pending Requests'),
      );
    });
  }
}
