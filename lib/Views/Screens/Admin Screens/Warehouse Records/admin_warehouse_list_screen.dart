import 'package:flutter/material.dart';
import 'package:project1/Models/Dummy%20Models/warehouses_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Admin%20Screens/Warehouse%20Records/admin_warehouse_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminWarehouseListScreen extends StatefulWidget {
  const AdminWarehouseListScreen({super.key});

  @override
  State<AdminWarehouseListScreen> createState() =>
      _AdminWarehouseListScreenState();
}

class _AdminWarehouseListScreenState extends State<AdminWarehouseListScreen> {
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Warehouses'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
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
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Icon(
                    Icons.search,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
                    itemCount: warehousesDummyListContents.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminWarehouseDetailsScreen(
                                            warehouseName:
                                                warehousesDummyListContents[
                                                        index]
                                                    .name,
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
                                        AssetImage(Constants.backgroundImage),
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
                                              width: 150,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                warehousesDummyListContents[
                                                        index]
                                                    .name,
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
                                                      warehousesDummyListContents[
                                                              index]
                                                          .address),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.store,
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
