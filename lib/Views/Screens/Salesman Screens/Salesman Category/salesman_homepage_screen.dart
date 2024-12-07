import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_homepage_view_model.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Cart/Start%20Trip/salesman_shops_list_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/Salesman%20Category/salesman_items_list_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_profile_screen.dart';
import 'package:project1/Views/Screens/Salesman%20Screens/salesman_trip_info_screen.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class SalesmanHomepageScreen extends StatefulWidget {
  const SalesmanHomepageScreen({super.key});

  @override
  State<SalesmanHomepageScreen> createState() => _SalesmanHomepageScreenState();
}

class _SalesmanHomepageScreenState extends State<SalesmanHomepageScreen> {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // authProvider.loginApi(
    //     AuthModel(
    //       email: "eve.holt@reqres.in",
    //       password: "cityslicka",
    //     ).toJson(),
    //     context);
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            color: AppColors.lightWhiteBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                _buildShowUserInfo(),
                SizedBox(height: 15),
                _buildShowSearchBar(),
                SizedBox(height: 15),
                _buildStartTripButton(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // _buildShowBannerImage(),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 20, top: 20),
                  //     child: Text(
                  //       'Categories',
                  //       style: AppTextStyles.simpleHeadingTextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // _buildShowCategoriesGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show user info
  Widget _buildShowUserInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FutureBuilderHelperWidget(
          future: context.read<SalesmanHomepageViewModel>().fetchSalesmanInfo(),
          onSuccess: (salesman) {
            // final salesman = result.data() as Map<String, dynamic>;
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => SalesmanProfileScreen(
                                  salesmanName:
                                      salesman['name'] ?? 'Loading...',
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: AppColors.loginBackground.withOpacity(.3),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          fit: BoxFit.cover,
                          salesman['imageUrl'] ?? '',
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageUrls.errorImage,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salesman['name'],
                      style:
                          AppTextStyles.belowMainHeadingTextStyle(fontSize: 15),
                    ),
                    Text(
                      'Salesman',
                      style:
                          AppTextStyles.belowMainHeadingTextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            );
          },
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('User Info Not Found'),
          errorWidget: Text('Error Getting User Info'),
        ),
      ],
    );
  }

  // Show search bar
  Widget _buildShowSearchBar() {
    return TextFormField(
      controller: _searchController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: AppColors.grey.withOpacity(.2),
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        suffixIcon: Icon(
          Icons.search,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // Trip info container
  Widget _buildStartTripButton() {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => SalesmanTripInfoScreen())),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // height: 200,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.green,
              AppColors.lightGreen1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Trip Info',
                style:
                    AppTextStyles.nameHeadingTextStyle(color: AppColors.white),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Total Products: 56',
                  style: AppTextStyles.nameHeadingTextStyle(
                    color: AppColors.lightWhiteBackground,
                    size: 13,
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Dated: 26 Nov 2024',
                  style: AppTextStyles.nameHeadingTextStyle(
                    color: AppColors.lightWhiteBackground,
                    size: 13,
                  ),
                )),
            SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesmanShopsListScreen(
                          isTripStarted: true, goToShopCart: () {}))),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.grey,
                      AppColors.grey.withOpacity(.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text('Start Trip',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Banner Image
  Widget _buildShowBannerImage() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage(ImageUrls.salesmanBannerImage)),
      ),
    );
  }

  // Show categories grid
  Widget _buildShowCategoriesGrid() {
    return FutureBuilderHelperWidget(
      future: context.read<SalesmanHomepageViewModel>().fetchCategories(),
      onSuccess: (categories) {
        // final categories = result.docs;
        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SalesmanItemsListScreen(
                                        categoryName: category.name ?? 'N/A',
                                        categoryIndex: index,
                                      )));
                        },
                        child: Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              category.imageUrl ?? '',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  fit: BoxFit.cover,
                                  ImageUrls.errorImage,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 100,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            category.name ?? 'N/A',
                            style: AppTextStyles.nameHeadingTextStyle(
                              size: 12,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      loadingWidget: CircularProgressIndicator(),
      emptyWidget: Text('No Categories Found'),
      errorWidget: Text('Error Getting Categories'),
    );
  }
}
