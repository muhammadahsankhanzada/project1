import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_pending_requests_view_model.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_request_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerPendingRequestsScreen extends StatelessWidget {
  final String managerName;
  const ManagerPendingRequestsScreen({super.key, required this.managerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Pending Requests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildShowPendingRequests(),
          ],
        ),
      ),
    );
  }

  // Stream to show pending requests list
  Widget _buildShowPendingRequests() {
    return Consumer<ManagerPendingRequestsViewModel>(
        builder: (context, value, child) {
      return FutureBuilderHelperWidget(
        future: value.fetchPendingRequests(managerName),
        onSuccess: (pendingRequests) {
          return Expanded(
            child: ListView.builder(
                itemCount: pendingRequests.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManagerPendingRequestDetailsScreen(
                                        salesmanId: pendingRequests[index]
                                            ['id'],
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
                                      fit: BoxFit.cover,
                                      width: 70,
                                      height: 70,
                                      pendingRequests[index]['imageUrl'],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pendingRequests[index]['name'],
                                      style: AppTextStyles
                                          .belowMainHeadingTextStyle(
                                              fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        'Route: ${pendingRequests[index]['route']}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles
                                            .simpleHeadingTextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Requested Products: ${pendingRequests[index]['productsRequested']}',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
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
        emptyWidget: Text('No Pending Requests Found'),
        errorWidget: Text('Error Getting Pending Requests'),
      );
    });
  }
}
