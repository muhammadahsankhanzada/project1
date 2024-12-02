import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_approved_requests_view_model.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerApprovedRequestsScreen extends StatelessWidget {
  final managerName;
  const ManagerApprovedRequestsScreen({super.key, required this.managerName});

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
            _buildShowApprovedRequests(),
          ],
        ),
      ),
    );
  }

  // Stream builder to show approved requests list
  Widget _buildShowApprovedRequests() {
    return Consumer<ManagerApprovedRequestsViewModel>(
        builder: (context, value, child) {
      return FutureBuilderHelperWidget(
        future: value.fetchApprovedRequests(managerName),
        onSuccess: (approvedRequests) {
          // final approvedRequests = result.docs;
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
                                        salesmanId: approvedRequests[index]
                                            ['id'],
                                        salesmanName: approvedRequests[index]
                                            ['name'],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  child: ClipOval(
                                    child: Image.network(
                                      approvedRequests[index]['imageUrl'],
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
                                      errorBuilder:
                                          (context, error, StackTrace) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Requested Products: ${approvedRequests[index]['productsRequested']}',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 10),
                                        child: Icon(
                                          Icons.done_all,
                                          size: 30,
                                          color: AppColors.green,
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
                  );
                }),
          );
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('No Approved Requests Found'),
        errorWidget: Text('Error Getting Approved Requests'),
      );
    });
  }
}
