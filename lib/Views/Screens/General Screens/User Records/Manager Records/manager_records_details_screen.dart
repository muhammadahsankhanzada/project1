import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_records_details_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Manager%20Records/Rejected%20Requests/manager_rejected_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_requests_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerRecordsDetailsScreen extends StatefulWidget {
  final String managerName;
  const ManagerRecordsDetailsScreen({
    super.key,
    required this.managerName,
  });

  @override
  State<ManagerRecordsDetailsScreen> createState() =>
      _ManagerRecordsDetailsScreenState();
}

class _ManagerRecordsDetailsScreenState
    extends State<ManagerRecordsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Manager Info'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _buildShowManagerDetails(),
        ),
      ),
    );
  }

  // Show manager details
  Widget _buildShowManagerDetails() {
    return Consumer<ManagerRecordsDetailsViewModel>(
        builder: (context, value, child) {
      return StreamBuilderHelperWidget(
        stream: value.fetchManagerRecords(widget.managerName),
        onSuccess: (result) {
          final manager = result.data() as Map<String, dynamic>;
          return Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.network(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    manager['imageUrl'],
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          ImageUrls.errorImage);
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen1.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var key in value.managerDetails.keys)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${key}:',
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var value in value.managerDetails.values)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              value.toString(),
                              style: AppTextStyles.belowMainHeadingTextStyle(
                                  fontSize: 15),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              _buildGoToDifferentScreens(
                  title: 'Approved Requests',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerApprovedRequestsScreen(
                                  managerName: widget.managerName,
                                )));
                  }),
              SizedBox(height: 15),
              _buildGoToDifferentScreens(
                  title: 'Pending Requests',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerPendingRequestsScreen(
                                  managerName: widget.managerName,
                                )));
                  }),
              SizedBox(height: 15),
              _buildGoToDifferentScreens(
                  title: 'Rejected Requests',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerRejectedRequestsScreen(
                                  managerName: widget.managerName,
                                )));
                  }),
            ],
          );
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('No Records Found'),
        errorWidget: Text('Error Fetching Records'),
      );
    });
  }

  // Go to different screen button
  Widget _buildGoToDifferentScreens({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.nameHeadingTextStyle(size: 16),
          ),
        ),
      ),
    );
  }
}
