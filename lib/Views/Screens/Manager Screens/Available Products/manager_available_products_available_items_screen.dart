import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';

class ManagerAvailableProductsAvailableItemsScreen extends StatefulWidget {
  // final categoryindex;
  const ManagerAvailableProductsAvailableItemsScreen({
    super.key,
    // required this.categoryindex,
  });

  @override
  State<ManagerAvailableProductsAvailableItemsScreen> createState() =>
      _ManagerAvailableProductsAvailableItemsScreenState();
}

class _ManagerAvailableProductsAvailableItemsScreenState
    extends State<ManagerAvailableProductsAvailableItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(Constants.backgroundImage)),
                              color: AppColors.white.withOpacity(.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Organic Ketchup',
                            style: AppTextStyles.nameHeadingTextStyle(
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
