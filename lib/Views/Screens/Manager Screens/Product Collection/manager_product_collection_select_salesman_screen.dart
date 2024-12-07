import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Manager%20View%20Models/manager_product_collection_select_salesman_view_model.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Product%20Collection/manager_product_collection_products_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class ManagerProductCollectionSelectSalesmanScreen extends StatelessWidget {
  const ManagerProductCollectionSelectSalesmanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Select Salesman'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Consumer<ManagerProductCollectionSelectSalesmanViewModel>(
                builder: (context, value, child) {
              return TextFormField(
                controller: _searchController,
                onChanged: value.onChanged,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter salesman name...',
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
              );
            }),
            SizedBox(height: 20),
            _buildSalesmanList(),
          ],
        ),
      ),
    );
  }

  // Salesmen listview widget
  Widget _buildSalesmanList() {
    return Expanded(
      child: Consumer<ManagerProductCollectionSelectSalesmanViewModel>(
          builder: (context, value, child) {
        return FutureBuilderHelperWidget(
          future: value.fetchSalesmenList(),
          onSuccess: (salesmen) {
            // final salesmen = result.docs;
            final filteredSalesmen = value.filterSalesmen(salesmen);

            return ListView.builder(
                itemCount: filteredSalesmen.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ManagerProductCollectionProductsScreen(
                                        warehouseName: filteredSalesmen[index]
                                                ['warehouse'] ??
                                            'Alpha Warehouse',
                                        salesmanName: filteredSalesmen[index]
                                            ['name'],
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
                                radius: 20,
                                child: ClipOval(
                                  child: Image.network(
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    filteredSalesmen[index]['imageUrl'] ?? '',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(ImageUrls.errorImage);
                                    },
                                  ),
                                ),
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
                                            filteredSalesmen[index]['name'] ??
                                                'N/A',
                                            style: AppTextStyles
                                                .nameHeadingTextStyle(size: 15),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Route: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  filteredSalesmen[index]
                                                          ['route'] ??
                                                      'N/A'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                    ),
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
                });
          },
          loadingWidget: CircularProgressIndicator(),
          emptyWidget: Text('No Salesmen Found'),
          errorWidget: Text('Error Fetching Salesmen'),
        );
      }),
    );
  }
}
