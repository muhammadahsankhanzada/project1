import 'package:flutter/material.dart';
import 'package:project1/Models/shops_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Shop%20Records/admin_shop_records_details_screen.dart';

class AdminShopRecordsScreen extends StatefulWidget {
  const AdminShopRecordsScreen({super.key});

  @override
  State<AdminShopRecordsScreen> createState() => _AdminShopRecordsScreenState();
}

class _AdminShopRecordsScreenState extends State<AdminShopRecordsScreen> {
  var _searchController = TextEditingController();
  List<ShopListModel> filteredShopsList = shopsListContents;
  List<ShopListModel> allShopsList = shopsListContents;
  void _filterShops(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredShopsList = allShopsList;
      });
    } else {
      setState(() {
        filteredShopsList = allShopsList
            .where(
                (shop) => shop.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        title: Text(
          'Shop Records',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              onChanged: _filterShops,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search shops...',
                hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    Icons.search,
                    color: AppColors.green,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: filteredShopsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminShopRecordsDetailsScreen(
                                            shopName:
                                                filteredShopsList[index].name,
                                            shopAddress:
                                                filteredShopsList[index]
                                                    .address,
                                          )));
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.white.withOpacity(.7),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(Constants.myImage),
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
                                            Text(
                                              filteredShopsList[index].name,
                                              style: AppTextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 15),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Located: ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(filteredShopsList[index]
                                                    .address),
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
                    })),
          ],
        ),
      ),
    );
  }
}
