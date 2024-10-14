import 'package:flutter/material.dart';
import 'package:project1/Models/warehouses_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_products_screen.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerAddProductWarehouseSelectionScreen extends StatefulWidget {
  const ManagerAddProductWarehouseSelectionScreen({super.key});

  @override
  State<ManagerAddProductWarehouseSelectionScreen> createState() =>
      _ManagerAddProductWarehouseSelectionScreenState();
}

class _ManagerAddProductWarehouseSelectionScreenState
    extends State<ManagerAddProductWarehouseSelectionScreen> {
  List<bool> selectedWarehouses = [];
  bool isSelectionModeOn = false;
  // Color containerBackgroundColor = AppColors.lightGreen;
  @override
  void initState() {
    super.initState();
    selectedWarehouses =
        List<bool>.filled(warehousesDummyListContents.length, false);
  }

  void _updateSelectionMode() {
    // Check if any warehouse is selected
    isSelectionModeOn = selectedWarehouses.any((selected) => selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Warehouse',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
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
                color: AppColors.white.withOpacity(.8),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.builder(
                  itemCount: warehousesDummyListContents.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                                          ManagerAddProductsScreen(
                                            warehouseList: [
                                              warehousesDummyListContents[index]
                                                  .name
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
                                    : AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              warehousesDummyListContents[index].name,
                              style:
                                  AppTextStyles.nameHeadingTextStyle(size: 15),
                            )),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
              SizedBox(height: 10),
              Visibility(
                visible: isSelectionModeOn,
                child: UniversalButton(
                    title: 'Continue',
                    ontap: () {
                      List<String> selectedWarehouseNames = [];
                      for (int i = 0; i < selectedWarehouses.length; i++) {
                        if (selectedWarehouses[i]) {
                          selectedWarehouseNames
                              .add(warehousesDummyListContents[i].name);
                        }
                      }
                      if (selectedWarehouseNames.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManagerAddProductsScreen(
                                    warehouseList: selectedWarehouseNames)));
                      } else {
                        customSnackbar(
                            context, 'Select a Warehouse to continue');
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
