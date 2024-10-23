import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Super%20Admin%20Screens/Product%20Management/super_admin_edit_products_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class SuperAdminEditProductWarehouseSelectionScreen extends StatefulWidget {
  const SuperAdminEditProductWarehouseSelectionScreen({super.key});

  @override
  State<SuperAdminEditProductWarehouseSelectionScreen> createState() =>
      _SuperAdminEditProductWarehouseSelectionScreenState();
}

class _SuperAdminEditProductWarehouseSelectionScreenState
    extends State<SuperAdminEditProductWarehouseSelectionScreen> {
  List<bool> selectedWarehouses = [];
  bool isSelectionModeOn = false;
  List<String> warehouseValuesList = [];

  @override
  void initState() {
    super.initState();
    fetchWarehouses();
  }

  void _updateSelectionMode() {
    // Check if any warehouse is selected
    isSelectionModeOn = selectedWarehouses.any((selected) => selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: AppBar(
        title: Text(
          'Select Warehouse',
          style: AppTextStyles.simpleHeadingTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textColor: AppColors.universalButtonGreen,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightWhiteBackground,
        actions: [
          InkWell(
            onTap: () {
              bool selectAll = !isSelectionModeOn;
              for (int i = 0; i < selectedWarehouses.length; i++) {
                selectedWarehouses[i] = selectAll;
              }
              isSelectionModeOn = selectAll;
              setState(() {});
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.lightGreen1,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                isSelectionModeOn ? 'Deselect all' : 'Select all',
                style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 12),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: warehouseValuesList == []
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: warehouseValuesList.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onLongPress: () {
                                  print('longtap');
                                  isSelectionModeOn = true;
                                  selectedWarehouses[index] =
                                      !selectedWarehouses[index];
                                  _updateSelectionMode();
                                  setState(() {});
                                },
                                onTap: () {
                                  print('ontap');
                                  if (isSelectionModeOn) {
                                    selectedWarehouses[index] =
                                        !selectedWarehouses[index];
                                    _updateSelectionMode();

                                    setState(() {});
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SuperAdminEditProductsScreen(
                                                  warehouseList: [
                                                    warehouseValuesList[index]
                                                  ],
                                                )));
                                  }
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 40),
                                  decoration: BoxDecoration(
                                      color: selectedWarehouses[index]
                                          ? AppColors.green.withOpacity(.7)
                                          : AppColors.lightGreen1
                                              .withOpacity(.7),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    warehouseValuesList[index],
                                    style: AppTextStyles.nameHeadingTextStyle(
                                        size: 15),
                                  )),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Visibility(
                    visible: isSelectionModeOn,
                    child: UniversalButton(
                        title: 'Continue',
                        textSize: 15,
                        ontap: () {
                          List<String> selectedWarehouseNames = [];
                          for (int i = 0; i < selectedWarehouses.length; i++) {
                            if (selectedWarehouses[i]) {
                              selectedWarehouseNames
                                  .add(warehouseValuesList[i]);
                            }
                          }
                          if (selectedWarehouseNames.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SuperAdminEditProductsScreen(
                                            warehouseList:
                                                selectedWarehouseNames)));
                          } else {
                            customSnackbar(
                                context, 'Select a Warehouse to continue');
                          }
                        }),
                  ),
                ],
              ),
      ),
    );
  }

  // Method to fetch warehouses list
  fetchWarehouses() async {
    // List<String> warehouses = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot warehouseSnapshot =
          await firestore.collection('Warehouses').get();
      warehouseValuesList =
          warehouseSnapshot.docs.map((doc) => doc.id).toList();
      selectedWarehouses = List<bool>.filled(warehouseValuesList.length, false);
      setState(() {}); // Update the UI after fetching data
    } catch (error) {
      print('Error getting data: $error');
    }
  }
}
