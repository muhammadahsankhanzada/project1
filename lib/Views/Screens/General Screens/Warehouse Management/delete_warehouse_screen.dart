import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/delete_warehouse_view_model.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class DeleteWarehouseScreen extends StatefulWidget {
  const DeleteWarehouseScreen({super.key});

  @override
  State<DeleteWarehouseScreen> createState() => _DeleteWarehouseScreenState();
}

class _DeleteWarehouseScreenState extends State<DeleteWarehouseScreen> {
  var _formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DeleteWarehouseViewModel>().resetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Delete Warehouse'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<DeleteWarehouseViewModel>(
              builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Delete Warehouse',
                      style: AppTextStyles.nameHeadingTextStyle(size: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius:
                          BorderRadius.circular(value.isSearching ? 15 : 30),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: value.onChanged,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Search warehouse name...',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
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
                        AnimatedSize(
                          duration: Duration(milliseconds: 500),
                          child: Visibility(
                            visible: value.isSearching,
                            child: Column(
                              children: [
                                Divider(
                                  color: AppColors.grey,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                _buildSteamBuilder(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: value.isWarehouseSelected,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(value.selectedWarehouseImage),
                          ),
                          Text(
                            value.selectedWarehouseName,
                            style: AppTextStyles.simpleHeadingTextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Contact:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Email:',
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.selectedWarehouseAddress,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      value.selectedWarehouseContact,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      value.selectedWarehouseEmail,
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: value.isWarehouseSelected,
                    child: UniversalButton(
                        buttonWidth: 250,
                        title: 'Delete Warehouse',
                        ontap: () {
                          if (_formKey.currentState!.validate()) {}

                          showDialog(
                              context: context,
                              builder: (BuildContext dialogBoxContext) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    height: 200,
                                    width: 300,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.lightGreen,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Text(
                                          'Confirm Deletion',
                                          style: AppTextStyles
                                              .nameHeadingTextStyle(),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Are you sure you want to delete this warehouse.',
                                          style: AppTextStyles
                                              .belowMainHeadingTextStyle(),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            UniversalButton(
                                                title: 'Cancel',
                                                buttonHeight: 40,
                                                buttonWidth: 110,
                                                ontap: () {
                                                  Navigator.pop(context);
                                                }),
                                            UniversalButton(
                                                title: 'Delete',
                                                buttonHeight: 40,
                                                buttonWidth: 110,
                                                buttonColor: AppColors
                                                    .universalButtonGreen,
                                                ontap: () {
                                                  value.deleteWarehouse(
                                                      value
                                                          .selectedWarehouseName,
                                                      context,
                                                      dialogBoxContext);
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // To search, filter and show warehouses
  Widget _buildSteamBuilder() {
    return Consumer<DeleteWarehouseViewModel>(builder: (context, value, child) {
      return StreamBuilderHelperWidget<QuerySnapshot>(
          stream: value.warehousesStream,
          onSuccess: (data) {
            final filteredWarehouses = value.getFilteredWarehouses(data.docs);

            return SizedBox(
              height: 300,
              child: filteredWarehouses.isEmpty
                  ? Center(
                      child: Text(
                      'No Warehouses found',
                      style: AppTextStyles.simpleHeadingTextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  : ListView.builder(
                      padding: EdgeInsets.only(left: 20),
                      itemCount: filteredWarehouses.length,
                      itemBuilder: (context, index) {
                        final warehouse = filteredWarehouses[index];
                        final warehouseImage = warehouse['imageUrl'];
                        final warehouseName = warehouse['name'] ?? 'No Name';
                        final warehouseAddress =
                            warehouse['address'] ?? 'No Address';

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(warehouseImage),
                          ),
                          title: Text(warehouseName),
                          subtitle: Text(warehouseAddress),
                          onTap: () {
                            value.selectWarehouse(warehouse);
                            _searchController.text = '';
                          },
                        );
                      },
                    ),
            );
          },
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('No Warehouses Found.'),
          errorWidget: Text('Error Searching Warehouses'));
    });
  }
}
