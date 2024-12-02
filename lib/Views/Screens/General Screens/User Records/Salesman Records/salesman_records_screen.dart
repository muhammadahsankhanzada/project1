import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/image_urls.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/View%20Models/Salesman%20View%20Models/salesman_records_view_model.dart';
import 'package:project1/Views/Screens/General%20Screens/User%20Records/Salesman%20Records/salesman_records_details_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';
import 'package:project1/Views/Widgets/future_builder_helper_widget.dart';
import 'package:project1/Views/Widgets/stream_builder_helper_widget.dart';
import 'package:provider/provider.dart';

class SalesmanRecordsScreen extends StatefulWidget {
  const SalesmanRecordsScreen({super.key});

  @override
  State<SalesmanRecordsScreen> createState() => _SalesmanRecordsScreenState();
}

class _SalesmanRecordsScreenState extends State<SalesmanRecordsScreen> {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Salesman Records'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Consumer<SalesmanRecordsViewModel>(
                builder: (context, value, child) {
              return TextFormField(
                controller: _searchController,
                onChanged: value.onChanged,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Search salesman name...',
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
      child:
          Consumer<SalesmanRecordsViewModel>(builder: (context, value, child) {
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
                                      SalesmanRecordsDetailsScreen(
                                        salesmanName: filteredSalesmen[index]
                                            ['name'],
                                        salesmanRoute: filteredSalesmen[index]
                                            ['route'],
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
                                    filteredSalesmen[index]['imageUrl'],
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
                                            filteredSalesmen[index]['name'],
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
                                                      ['route']),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.assessment,
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
