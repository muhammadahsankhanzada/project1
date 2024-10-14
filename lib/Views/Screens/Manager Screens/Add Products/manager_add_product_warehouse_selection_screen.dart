import 'package:flutter/material.dart';
import 'package:project1/Models/warehouses_list_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Add%20Products/manager_add_products_screen.dart';
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
  // Color containerBackgroundColor = AppColors.lightGreen;
  @override
  void initState() {
    super.initState();
    selectedWarehouses =
        List<bool>.filled(warehousesDummyListContents.length, false);
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
              for (int i = 0; i < selectedWarehouses.length; i++) {
                selectedWarehouses[i] = !selectedWarehouses[i];
              }
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
                'Select all',
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
              ListView.builder(
                  itemCount: warehousesDummyListContents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onLongPress: () {
                            print('longtap');
                            selectedWarehouses[index] =
                                !selectedWarehouses[index];
                            setState(() {});
                          },
                          onTap: () {
                            print('ontap');
                            if (!selectedWarehouses[index]) {
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
                            // else {
                            //   selectedWarehouses[index] =
                            //       !selectedWarehouses[index];
                            //   setState(() {});
                            // }
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                color: selectedWarehouses[index]
                                    ? AppColors.green.withOpacity(.7)
                                    : AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(30)),
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
              UniversalButton(
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
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
