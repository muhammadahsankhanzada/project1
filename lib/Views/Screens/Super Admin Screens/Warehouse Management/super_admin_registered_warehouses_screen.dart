import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Warehouse%20Records/admin_warehouse_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class SuperAdminRegisteredWarehousesScreen extends StatefulWidget {
  const SuperAdminRegisteredWarehousesScreen({super.key});

  @override
  State<SuperAdminRegisteredWarehousesScreen> createState() =>
      _SuperAdminRegisteredWarehousesScreenState();
}

class _SuperAdminRegisteredWarehousesScreenState
    extends State<SuperAdminRegisteredWarehousesScreen> {
  var _searchController = TextEditingController();
  String searchedText = '';

  _onChanged(String value) {
    setState(() {
      searchedText = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Registered Warehouses'),
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
                hintText: 'Search warehouse name...',
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
            searchWarehouses(),
            // Expanded(
            //     child: ListView.builder(
            //         shrinkWrap: true,
            //         // physics: NeverScrollableScrollPhysics(),
            //         itemCount: warehousesDummyListContents.length,
            //         itemBuilder: (context, index) {
            //           return Column(
            //             children: [
            //               InkWell(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                               AdminWarehouseDetailsScreen(
            //                                 warehouseName:
            //                                     warehousesDummyListContents[
            //                                             index]
            //                                         .name,
            //                               )));
            //                 },
            //                 borderRadius: BorderRadius.circular(40),
            //                 child: Container(
            //                   width: double.infinity,
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 30, vertical: 15),
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(40),
            //                     color: AppColors.white,
            //                   ),
            //                   child: Row(
            //                     children: [
            //                       CircleAvatar(
            //                         backgroundImage:
            //                             AssetImage(Constants.backgroundImage),
            //                       ),
            //                       SizedBox(width: 15),
            //                       Expanded(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 SizedBox(
            //                                   width: 200,
            //                                   child: Text(
            //                                     overflow: TextOverflow.ellipsis,
            //                                     warehousesDummyListContents[
            //                                             index]
            //                                         .name,
            //                                     style: AppTextStyles
            //                                         .nameHeadingTextStyle(
            //                                             size: 15),
            //                                   ),
            //                                 ),
            //                                 Row(
            //                                   children: [
            //                                     Text(
            //                                       'Location: ',
            //                                       style: TextStyle(
            //                                         fontWeight: FontWeight.w500,
            //                                       ),
            //                                     ),
            //                                     SizedBox(
            //                                       width: 150,
            //                                       child: Text(
            //                                           overflow:
            //                                               TextOverflow.ellipsis,
            //                                           warehousesDummyListContents[
            //                                                   index]
            //                                               .address),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                             Icon(
            //                               Icons.store,
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 10),
            //             ],
            //           );
            //         }))
          ],
        ),
      ),
    );
  }

  Widget searchWarehouses() {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('Warehouses');

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
          return Center(child: Text('No warehouses found.'));
        }

        final warehouses = snapshot.data!.docs;

        // Filter warehouses based on the searchedText
        final filteredWarehouses = warehouses.where((warehouse) {
          final warehouseName = (warehouse['name'] ?? '').toLowerCase();
          return warehouseName.contains(searchedText);
        }).toList();

        return Expanded(
          child: filteredWarehouses.isEmpty
              ? Center(
                  child: Text(
                  'No Warehouses found',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredWarehouses.length,
                  itemBuilder: (context, index) {
                    final warehouse = filteredWarehouses[index];
                    final warehouseImage = warehouse['imageUrl'];
                    final warehouseName = warehouse['name'] ?? 'N/A';
                    final warehouseAddress = warehouse['address'] ?? 'N/A';
                    final warehouseContact = warehouse['contact'] ?? 'N/A';
                    final warehouseEmail = warehouse['email'] ?? 'N/A';

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AdminWarehouseDetailsScreen(
                                          warehouseName: warehouseName,
                                          warehouseImageUrl: warehouseImage,
                                          warehouseAddress: warehouseAddress,
                                          warehouseContact: warehouseContact,
                                          warehouseEmail: warehouseEmail,
                                          warehouseSpaceAvailable: '3000 ft',
                                          warehouseLoadingDocks: '03',
                                          warehouseStorageCapacity:
                                              '5000 pounds',
                                          warehouseEntries: '02',
                                          warehouseManagerName: 'Shumail Khan',
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
                                  backgroundImage: NetworkImage(warehouseImage),
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
                                              warehouseName,
                                              style: AppTextStyles
                                                  .nameHeadingTextStyle(
                                                      size: 15),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Location: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    warehouseAddress),
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
