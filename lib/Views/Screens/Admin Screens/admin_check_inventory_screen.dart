import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_items_list_screen.dart';
import 'package:project1/Views/Widgets/network_image_loader.dart';

class AdminCheckInventoryScreen extends StatelessWidget {
  const AdminCheckInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Inventory',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Categories',
                    style: AppTextStyles.nameHeadingTextStyle(size: 20),
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: ListView.builder(
                  itemCount: productCategoriesDummyModelContents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.green,
                            width: 2,
                          )),
                      child: Text(
                        productCategoriesDummyModelContents[index].name,
                        style: AppTextStyles.nameHeadingTextStyle(size: 15),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: productCategoriesDummyModelContents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ManagerAvailableProductsItemsListScreen()));
                          },
                          child: Container(
                            height: 150,
                            width: 180,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      productCategoriesDummyModelContents[index]
                                          .imageUrl)),
                              color: AppColors.white.withOpacity(.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          productCategoriesDummyModelContents[index].name,
                          style: AppTextStyles.nameHeadingTextStyle(
                            size: 16,
                          ),
                        )
                      ],
                    );
                  }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
