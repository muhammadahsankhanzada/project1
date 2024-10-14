import 'package:flutter/material.dart';
import 'package:project1/Models/product_categories_dummy_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/Driver%20Cart/Start%20Trip/Shop%20Required%20Items/driver_required_items_screen.dart';

class DriverRequiredCategoryScreen extends StatelessWidget {
  const DriverRequiredCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                                      DriverRequiredItemsScreen(
                                        categoryIndex: index,
                                      )));
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
                            color: AppColors.white.withOpacity(.9),
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
    );
  }
}
