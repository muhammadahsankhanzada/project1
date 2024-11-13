import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/registered_warehouses_view_model.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Warehouse%20Records/admin_warehouse_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class RegisteredWarehousesScreen extends StatefulWidget {
  const RegisteredWarehousesScreen({super.key});

  @override
  State<RegisteredWarehousesScreen> createState() =>
      _RegisteredWarehousesScreenState();
}

class _RegisteredWarehousesScreenState
    extends State<RegisteredWarehousesScreen> {
  var _searchController = TextEditingController();

  @override
  void initState() {
    // Reset screen state
    Future.microtask(() {
      context.read<RegisteredWarehousesViewModel>().resetState();
    });
    super.initState();
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
            Consumer<RegisteredWarehousesViewModel>(
                builder: (context, value, child) {
              return TextFormField(
                controller: _searchController,
                onChanged: value.onChanged,
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
              );
            }),
            SizedBox(height: 20),
            _buildSteamBuilder(),
          ],
        ),
      ),
    );
  }

  // To search, filter and show warehouses
  Widget _buildSteamBuilder() {
    return Consumer<RegisteredWarehousesViewModel>(
        builder: (context, value, child) {
      return StreamBuilderHelperWidget<QuerySnapshot>(
          stream: value.warehousesStream,
          onSuccess: (data) {
            final filteredWarehouses = value.getFilteredWarehouses(data.docs);

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
                      itemCount: filteredWarehouses.length,
                      itemBuilder: (context, index) {
                        final warehouse = filteredWarehouses[index];
                        final warehouseImage = warehouse['imageUrl'];
                        final warehouseName = warehouse['name'] ?? 'No Name';
                        final warehouseAddress =
                            warehouse['address'] ?? 'No Address';
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
                                              warehouseAddress:
                                                  warehouseAddress,
                                              warehouseContact:
                                                  warehouseContact,
                                              warehouseEmail: warehouseEmail,
                                              warehouseSpaceAvailable:
                                                  '3000 ft',
                                              warehouseLoadingDocks: '03',
                                              warehouseStorageCapacity:
                                                  '5000 pounds',
                                              warehouseEntries: '02',
                                              warehouseManagerName:
                                                  'Shumail Khan',
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
                                      backgroundImage:
                                          NetworkImage(warehouseImage),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('No Warehouses found.'),
          errorWidget: Text('Error Searching Warehouses'));
    });
  }
}
