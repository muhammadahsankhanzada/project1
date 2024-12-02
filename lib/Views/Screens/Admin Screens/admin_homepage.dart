import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Admin%20View%20Models/admin_homepage_view_model.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: _buildCustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 10),
          _buildSearchBox(),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    _buildShowDashboardReports(),
                    SizedBox(height: 10),
                    ...context
                        .read<AdminHomepageViewModel>()
                        .options
                        .map((option) {
                      return _buildCustomButton(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        option['screen'] as Widget));
                          },
                          title: option['title'] as String,
                          icon: option['icon'] as IconData);
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

  // Appbar
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Consumer<AdminHomepageViewModel>(
                  builder: (context, value, child) {
                return StreamBuilderHelperWidget(
                  stream: value.fetchAdminDetails(),
                  onSuccess: (result) {
                    final adminDetails = result.data() as Map<String, dynamic>;
                    return CircleAvatar(
                      radius: 18,
                      child: ClipOval(
                        child: Image.network(
                          fit: BoxFit.cover,
                          adminDetails['imageUrl'],
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(ImageUrls.errorImage);
                          },
                        ),
                      ),
                    );
                  },
                  loadingWidget: CircularProgressIndicator(),
                  emptyWidget:
                      Image.asset(width: 18, height: 18, ImageUrls.errorImage),
                  errorWidget:
                      Image.asset(width: 18, height: 18, ImageUrls.errorImage),
                );
              }),
              SizedBox(width: 5),
              Text(
                'Admin',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Text(
            'Welcome!',
            style: AppTextStyles.simpleHeadingTextStyle(
              fontWeight: FontWeight.bold,
              textColor: AppColors.red,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view_outlined,
                color: AppColors.universalButtonGreen,
              ),
              SizedBox(width: 5),
              Text(
                'Dashboard',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: AppColors.lightWhiteBackground,
    );
  }

  // Search Box
  Widget _buildSearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          // controller: _searchController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Search',
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            suffixIcon: Icon(
              Icons.search,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  // Go to different screens button
  Widget _buildCustomButton(
      {required VoidCallback ontap,
      required String title,
      required IconData icon}) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(10),
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.loginBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.simpleHeadingTextStyle(
                      textColor: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    icon,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // Show info in containers
  Widget _buildReportsInfoContainer({
    required String type,
    required String percentage,
    required String amount,
    required String previousAmount,
    Color percentageColor = AppColors.green,
  }) {
    return Container(
      width: 180,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.black1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                type,
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: AppColors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '+${percentage}%',
                style: AppTextStyles.simpleHeadingTextStyle(
                  textColor: percentageColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            '\$${amount}',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Compared to',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 12,
            ),
          ),
          Text(
            '(\$${previousAmount} last year)',
            style: AppTextStyles.simpleHeadingTextStyle(
              textColor: AppColors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Show dashboard reports
  Widget _buildShowDashboardReports() {
    return Consumer<AdminHomepageViewModel>(builder: (context, value, child) {
      return StreamBuilderHelperWidget(
        stream: value.fetchDashboardReports(),
        onSuccess: (result) {
          final data = result.data() as Map<String, dynamic>;
          return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.7,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final reportsContainerData = value.showReportsData(data)[index];

                return _buildReportsInfoContainer(
                  type: reportsContainerData['type'],
                  percentage: reportsContainerData['percentage'].toString(),
                  percentageColor: reportsContainerData['amount'] <
                          reportsContainerData['previousAmount']
                      ? AppColors.red
                      : AppColors.green,
                  amount: reportsContainerData['amount'].toString(),
                  previousAmount:
                      reportsContainerData['previousAmount'].toString(),
                );
              });
        },
        loadingWidget: _buildDashboardReportsLoading(),
        emptyWidget: Text('No Reports Found'),
        errorWidget: Text('Error Getting Reports'),
      );
    });
  }

  // Dashboard reports loading
  Widget _buildDashboardReportsLoading() {
    return Shimmer.fromColors(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.7,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildReportsInfoContainer(
                type: '',
                percentage: '',
                percentageColor: AppColors.white,
                amount: '',
                previousAmount: '',
              );
            }),
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor);
  }
}
