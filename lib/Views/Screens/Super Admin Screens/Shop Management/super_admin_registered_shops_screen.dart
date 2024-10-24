import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Shop%20Records/admin_shop_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SuperAdminRegisteredShopsScreen extends StatefulWidget {
  const SuperAdminRegisteredShopsScreen({super.key});

  @override
  State<SuperAdminRegisteredShopsScreen> createState() =>
      _SuperAdminRegisteredShopsScreenState();
}

class _SuperAdminRegisteredShopsScreenState
    extends State<SuperAdminRegisteredShopsScreen> {
  var _searchController = TextEditingController();
  String searchedText = '';

  void _onChanged(String value) {
    setState(() {
      searchedText = value.toLowerCase();
    });
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
            TextFormField(
              controller: _searchController,
              onChanged: _onChanged,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Enter driver name here';
              //   }
              //   return null;
              // },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Search shop name',
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
            SizedBox(height: 20),
            searchShops(),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: shopsListContents.length,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) =>
            //                           AdminShopRecordsDetailsScreen(
            //                             shopName: shopsListContents[index].name,
            //                             shopAddress:
            //                                 shopsListContents[index].address,
            //                           )));
            //             },
            //             borderRadius: BorderRadius.circular(40),
            //             child: Container(
            //               width: double.infinity,
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 30, vertical: 15),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(40),
            //                 color: AppColors.white,
            //               ),
            //               child: Row(
            //                 children: [
            //                   CircleAvatar(
            //                     backgroundImage: AssetImage(
            //                         shopsListContents[index].imageUrl),
            //                   ),
            //                   SizedBox(width: 15),
            //                   Expanded(
            //                     child: Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             SizedBox(
            //                               width: 200,
            //                               child: Text(
            //                                 overflow: TextOverflow.ellipsis,
            //                                 shopsListContents[index].name,
            //                                 style: AppTextStyles
            //                                     .nameHeadingTextStyle(size: 15),
            //                               ),
            //                             ),
            //                             Row(
            //                               children: [
            //                                 Text(
            //                                   'Address: ',
            //                                   style: TextStyle(
            //                                     fontWeight: FontWeight.w500,
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   width: 150,
            //                                   child: Text(
            //                                       overflow:
            //                                           TextOverflow.ellipsis,
            //                                       shopsListContents[index]
            //                                           .address),
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                         Icon(
            //                           Icons.assessment,
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           SizedBox(height: 10),
            //         ],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget searchShops() {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('Shops');

    return StreamBuilder<QuerySnapshot>(
      stream: firestore.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No shops found.'));
        }

        final shops = snapshot.data!.docs;

        // Filter shops based on the searchedText
        final filteredShops = shops.where((shop) {
          final shopName = (shop['name'] ?? '').toLowerCase();
          // final shopAddress = (shop['address'] ?? '').toLowerCase();
          return shopName.contains(searchedText);
          //  || shopAddress.contains(searchedText);
        }).toList();

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
                  shrinkWrap: true,
                  itemCount: filteredShops.length,
                  itemBuilder: (context, index) {
                    final shop = filteredShops[index];
                    final shopImage = shop['imageUrl'];
                    final shopName = shop['name'] ?? 'N/A';
                    final shopAddress = shop['address'] ?? 'N/A';
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
                                              overflow: TextOverflow.ellipsis,
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
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
    );
  }
}
