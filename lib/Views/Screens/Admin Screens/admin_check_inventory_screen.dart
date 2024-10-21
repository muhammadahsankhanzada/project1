import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Manager%20Screens/Available%20Products/manager_available_products_items_list_screen.dart';
import 'package:project1/Views/Widgets/custom_appbar.dart';

class AdminCheckInventoryScreen extends StatefulWidget {
  const AdminCheckInventoryScreen({super.key});

  @override
  State<AdminCheckInventoryScreen> createState() =>
      _AdminCheckInventoryScreenState();
}

class _AdminCheckInventoryScreenState extends State<AdminCheckInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhiteBackground,
      appBar: CustomAppbar(title: 'Inventory'),
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
                    style: AppTextStyles.simpleHeadingTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.universalButtonGreen,
                    ),
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
                    return InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ManagerAvailableProductsItemsListScreen(
                                        categoryIndex: index)));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            )),
                        child: Center(
                          child: Text(
                            productCategoriesDummyModelContents[index].name,
                            style: AppTextStyles.nameHeadingTextStyle(size: 15),
                          ),
                        ),
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
                                        ManagerAvailableProductsItemsListScreen(
                                          categoryIndex: index,
                                        )));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 150,
                                width: 180,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          productCategoriesDummyModelContents[
                                                  index]
                                              .imageUrl)),
                                  color: AppColors.white.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: EdgeInsets.only(right: 20, top: 20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '30 Products',
                                    style: AppTextStyles.simpleHeadingTextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
