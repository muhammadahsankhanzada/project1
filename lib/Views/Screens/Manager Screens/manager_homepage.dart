import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_warehouse_cart_screen.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_category_screen.dart';

class ManagerHomepage extends StatelessWidget {
  const ManagerHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categoryList = [
      'Pending Requests',
      'Approved Requests',
      'Add Product',
      'Delete Product',
      'Available Products',
      'Driver Records'
    ];
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Manager',
              style: AppTextStyles.nameHeadingTextStyle(),
            ),
            centerTitle: true,
            backgroundColor: AppColors.green,
          ),
          body: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      Constants.logoImage,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Robert Williamson',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                      Text(
                        'Warehouse Manager',
                        style: AppTextStyles.belowMainHeadingTextStyle(
                            fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 150,
                          // width: 200,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                Constants.logoImage,
                                width: 100,
                              ),
                              Text(
                                categoryList[index],
                                style: AppTextStyles.belowMainHeadingTextStyle(
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
