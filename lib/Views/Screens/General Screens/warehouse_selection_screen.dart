import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/General%20View%20Models/warehouse_selection_view_model.dart';
import 'package:project1/Views/Widgets/universal_button.dart';
import 'package:provider/provider.dart';

class WarehouseSelectionScreen extends StatefulWidget {
  final String selectedScreen;
  const WarehouseSelectionScreen({super.key, required this.selectedScreen});

  @override
  State<WarehouseSelectionScreen> createState() =>
      _WarehouseSelectionScreenState();
}

class _WarehouseSelectionScreenState extends State<WarehouseSelectionScreen> {
  late WarehouseSelectionViewModel _warehouseSelectionViewModel;

  @override
  void initState() {
    final viewModel =
        Provider.of<WarehouseSelectionViewModel>(context, listen: false);
    viewModel.fetchWarehouses();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only set _warehouseSelectionViewModel if it is not already set
    if (!mounted) return;
    _warehouseSelectionViewModel =
        Provider.of<WarehouseSelectionViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _warehouseSelectionViewModel.resetViewModel();
    super.dispose();
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
          Consumer<WarehouseSelectionViewModel>(
              builder: (context, value, child) {
            return InkWell(
              onTap: () {
                value.selectAll();
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen1,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  value.isSelectionModeOn ? 'Deselect all' : 'Select all',
                  style: AppTextStyles.simpleHeadingTextStyle(
                    fontSize: 12,
                    textColor: AppColors.white,
                  ),
                ),
              ),
            );
          }),
          SizedBox(width: 10),
        ],
      ),
      body: Consumer<WarehouseSelectionViewModel>(
          builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: value.warehouseValuesList == []
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                          itemCount: value.warehouseValuesList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onLongPress: () {
                                    value.onLongPress(index);
                                  },
                                  onTap: () {
                                    if (value.isSelectionModeOn) {
                                      value.onTap(index);
                                    } else {
                                      List<String> selectedWarehouse = [];
                                      selectedWarehouse.add(
                                          value.warehouseValuesList[index]);
                                      value.goToDifferentScreens(
                                          widget.selectedScreen,
                                          selectedWarehouse,
                                          context);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        color: value.selectedWarehouses[index]
                                            ? AppColors.green.withOpacity(.7)
                                            : AppColors.lightGreen1
                                                .withOpacity(.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      value.warehouseValuesList[index],
                                      style:
                                          AppTextStyles.simpleHeadingTextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.white,
                                      ),
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
                      visible: value.isSelectionModeOn,
                      child: UniversalButton(
                          title: 'Continue',
                          textSize: 15,
                          ontap: () {
                            if (value.getSelectedWarehouseNames().isNotEmpty) {
                              value.goToDifferentScreens(widget.selectedScreen,
                                  value.getSelectedWarehouseNames(), context);
                            }
                          }),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
