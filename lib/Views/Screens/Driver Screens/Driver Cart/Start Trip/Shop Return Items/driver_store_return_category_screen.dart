import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Return%20Items/driver_return_item_screen.dart';

class DriverStoreReturnCategoryScreen extends StatefulWidget {
  const DriverStoreReturnCategoryScreen({super.key});

  @override
  State<DriverStoreReturnCategoryScreen> createState() =>
      _DriverStoreReturnCategoryScreenState();
}

class _DriverStoreReturnCategoryScreenState
    extends State<DriverStoreReturnCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Container(
              height: 40,
              width: double.infinity,
              child: ListView.builder(
                itemCount: productCategoriesDummyModelContents.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverReturnItemScreen(
                                  categoryIndex: index)));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.lightGreen1.withOpacity(.3),
                      ),
                      child: Center(
                        child: Text(
                          productCategoriesDummyModelContents[index].name,
                          style: AppTextStyles.belowMainHeadingTextStyle(
                              fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: productCategoriesDummyModelContents.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverReturnItemScreen(
                                        categoryIndex: index,
                                      )));
                        },
                        child: Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    productCategoriesDummyModelContents[index]
                                        .imageUrl)),
                            color: AppColors.white.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        productCategoriesDummyModelContents[index].name,
                        style: AppTextStyles.simpleHeadingTextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  );
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
