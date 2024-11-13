import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/registered_shops_view_model.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Shop%20Records/admin_shop_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class RegisteredShopsScreen extends StatefulWidget {
  const RegisteredShopsScreen({super.key});

  @override
  State<RegisteredShopsScreen> createState() => _RegisteredShopsScreenState();
}

class _RegisteredShopsScreenState extends State<RegisteredShopsScreen> {
  var _searchController = TextEditingController();

  @override
  void initState() {
    // Reset screen state
    Future.microtask(() {
      context.read<RegisteredShopsViewModel>().resetState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Registered Shops'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10),
            Consumer<RegisteredShopsViewModel>(
                builder: (context, value, child) {
              return TextFormField(
                controller: _searchController,
                onChanged: value.onChanged,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Search shop name...',
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
              );
            }),
            SizedBox(height: 20),
            _buildSteamBuilder(),
          ],
        ),
      ),
    );
  }

// To search, filter and show shops
  Widget _buildSteamBuilder() {
    return Consumer<RegisteredShopsViewModel>(builder: (context, value, child) {
      return StreamBuilderHelperWidget<QuerySnapshot>(
          stream: value.shopsStream,
          onSuccess: (data) {
            final filteredShops = value.getFilteredShops(data.docs);

            return Expanded(
              child: filteredShops.isEmpty
                  ? Center(
                      child: Text(
                      'No Shops found',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  : ListView.builder(
                      itemCount: filteredShops.length,
                      itemBuilder: (context, index) {
                        final shop = filteredShops[index];
                        final shopImage = shop['imageUrl'];
                        final shopName = shop['name'] ?? 'No Name';
                        final shopAddress = shop['address'] ?? 'No Address';

                        final shopIntro = shop['intro'] ?? 'N/A';
                        final shopType = shop['type'] ?? 'N/A';
                        final shopTimings = shop['timings'] ?? 'N/A';
                        final shopContact = shop['contact'] ?? 'N/A';
                        final shopEmail = shop['email'] ?? 'N/A';

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdminShopRecordsDetailsScreen(
                                              shopName: shopName,
                                              shopAddress: shopAddress,
                                              shopImage: shopImage,
                                              shopIntro: shopIntro,
                                              shopType: shopType,
                                              shopTimings: shopTimings,
                                              shopContact: shopContact,
                                              shopEmail: shopEmail,
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
                                      backgroundImage: NetworkImage(shopImage),
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
                                                width: 200,
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  shopName,
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
                                                        shopAddress),
                                                  ),
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
                      },
                    ),
            );
          },
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('No shops found.'),
          errorWidget: Text('Error Searching Shops'));
    });
  }
}
