import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminRemoveWarehouseScreen extends StatefulWidget {
  const SuperAdminRemoveWarehouseScreen({super.key});

  @override
  State<SuperAdminRemoveWarehouseScreen> createState() =>
      _SuperAdminRemoveWarehouseScreenState();
}

class _SuperAdminRemoveWarehouseScreenState
    extends State<SuperAdminRemoveWarehouseScreen> {
  var _formKey = GlobalKey<FormState>();
  var _searchController = TextEditingController();
  bool isSearching = false;
  bool isWarehouseSelected = false;
  String searchedText = '';

  // Selected shop details
  String selectedWarehouseName = '';
  String selectedWarehouseImage = '';
  String selectedWarehouseAddress = '';
  String selectedWarehouseContact = '';
  String selectedWarehouseEmail = '';

  void _onChanged(String value) {
    setState(() {
      isSearching = value.isNotEmpty; // Update isSearching based on input
      searchedText = value.toLowerCase();
      isWarehouseSelected = false;
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
          child: Form(
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
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     'Are you sure you want to permanently remove this warehouse and all its associated data?',
                //     style: AppTextStyles.belowMainHeadingTextStyle(
                //       fontSize: 15,
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(isSearching ? 15 : 30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: TextFormField(
                          controller: _searchController,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Enter driver name here';
                          //   }
                          //   return null;
                          // },
                          onChanged: _onChanged,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Search warehouse name...',
                            // filled: true,
                            // fillColor: AppColors.white,
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
                          visible: isSearching,
                          child: Column(
                            children: [
                              Divider(
                                color: AppColors.grey,
                                indent: 30,
                                endIndent: 30,
                              ),
                              searchWarehouses(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: isWarehouseSelected,
                  child: Container(
                    // height: 200,
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
                          backgroundImage: NetworkImage(selectedWarehouseImage),
                        ),
                        Text(
                          selectedWarehouseName,
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
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Contact:',
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Email:',
                                    style: AppTextStyles.simpleHeadingTextStyle(
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
                                    selectedWarehouseAddress,
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    selectedWarehouseContact,
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    selectedWarehouseEmail,
                                    style: AppTextStyles.simpleHeadingTextStyle(
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
                  visible: isWarehouseSelected,
                  child: UniversalButton(
                      buttonWidth: 250,
                      title: 'Delete Warehouse',
                      ontap: () {
                        if (_formKey.currentState!.validate()) {}

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  height: 200,
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
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
                                              // buttonColor: AppColors.red.shade300,
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
                                                deleteWarehouse(
                                                    selectedWarehouseName);
                                                Navigator.pop(context);
                                                customSnackbar(context,
                                                    'Warehouse perminently deleted.');
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
          ),
        ),
      ),
    );
  }

  // Custom Textfield
  textField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required FormFieldValidator validator,
    required TextInputType keyboardType,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.nameHeadingTextStyle(size: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                icon,
                color: AppColors.green,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
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
          return Center(child: Text('No Warehouses found.'));
        }

        final warehouses = snapshot.data!.docs;

        // Filter Warehouses based on the searchedText
        final filteredWarehouses = warehouses.where((warehouse) {
          final warehouseName = (warehouse['name'] ?? '').toLowerCase();
          return warehouseName.contains(searchedText);
        }).toList();

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
                      subtitle: Text('Location: $warehouseAddress'),
                      onTap: () {
                        // Assign the selected shop details
                        selectedWarehouseName =
                            filteredWarehouses[index]['name'];
                        selectedWarehouseImage =
                            filteredWarehouses[index]['imageUrl'] ?? '';
                        selectedWarehouseAddress = filteredWarehouses[index]
                                ['address'] ??
                            'No Address';
                        selectedWarehouseContact = filteredWarehouses[index]
                                ['contact'] ??
                            'No Contact';
                        selectedWarehouseEmail =
                            filteredWarehouses[index]['email'] ?? 'No Email';
                        setState(() {
                          _searchController.text = '';
                          searchedText = '';
                          isSearching = false;
                          isWarehouseSelected = true;
                          final selectedWarehouseName =
                              filteredWarehouses[index]['name'];
                          print(selectedWarehouseName);
                        });
                      },
                    );
                  },
                ),
        );
      },
    );
  }

  deleteWarehouse(String warehouseId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('Warehouses').doc(warehouseId).delete();
    print('Warehouse deleted with id: $warehouseId');
  }
}
