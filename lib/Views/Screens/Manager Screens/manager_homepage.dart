import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/manager_homepage_items.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_homepage_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/Inventory/check_inventory_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/warehouse_selection_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Approved%20Requests/manager_approved_requests_screen.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Pending%20Requests/manager_pending_requests_screen.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Product%20Collection/manager_product_collection_select_salesman_screen.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerHomepage extends StatelessWidget {
  const ManagerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: _buildShowAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShowUserInfo(),
          SizedBox(height: 10),
          _buildSearchField(),
          SizedBox(height: 10),
          _buildShowGridViewContainers(),
        ],
      ),
    );
  }

  // Appbar
  PreferredSizeWidget _buildShowAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people,
                color: AppColors.universalButtonGreen,
              ),
              SizedBox(width: 10),
              Text(
                'Manager',
                style: AppTextStyles.simpleHeadingTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.universalButtonGreen,
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

  // Show user info
  Widget _buildShowUserInfo() {
    return Consumer<ManagerHomepageViewModel>(builder: (context, value, child) {
      return FutureBuilderHelperWidget(
        future: value.fetchManagerDetails(),
        onSuccess: (managerInfo) {
          return Row(
            children: [
              SizedBox(width: 20),
              CircleAvatar(
                radius: 20,
                child: ClipOval(
                  child: Image.network(
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    managerInfo['imageUrl'] ?? '',
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImageUrls.errorImage,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
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
                    managerInfo['name'] ?? 'Loading...',
                    style: AppTextStyles.nameHeadingTextStyle(size: 13),
                  ),
                  Text(
                    'Warehouse Manager',
                    style: AppTextStyles.simpleHeadingTextStyle(fontSize: 13),
                  ),
                ],
              )
            ],
          );
        },
        loadingWidget: CircularProgressIndicator(),
        emptyWidget: Text('User Info Not Found'),
        errorWidget: Text('Error Getting User Info'),
      );
    });
  }

  // Show search bar
  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
    );
  }

  // Show grid view containers
  Widget _buildShowGridViewContainers() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(ImageUrls.managerBack)),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.9,
                  crossAxisCount: 2,
                ),
                itemCount: managerHomepageContents.length,
                itemBuilder: (context, index) {
                  return _buildButtonContainer(() {
                    if (index % 7 == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagerPendingRequestsScreen(
                                    managerName: 'Ahsan',
                                  )));
                    }
                    if (index % 7 == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagerApprovedRequestsScreen(
                                    managerName: 'Ahsan',
                                  )));
                    }
                    if (index % 7 == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WarehouseSelectionScreen(
                                    selectedScreen: 'Add Products',
                                  )));
                    }
                    if (index % 7 == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WarehouseSelectionScreen(
                                    selectedScreen: 'Delete Products',
                                  )));
                    }
                    if (index % 7 == 4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckInventoryScreen()));
                    }
                    if (index % 7 == 5) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalesmanRecordsScreen()));
                    }
                    if (index % 7 == 6) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagerProductCollectionSelectSalesmanScreen()));
                    }
                  }, managerHomepageContents[index].image,
                      managerHomepageContents[index].title);
                }),
          ],
        ),
      ),
    );
  }

  // Go to different screens button
  Widget _buildButtonContainer(VoidCallback ontap, String image, String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: ontap,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
