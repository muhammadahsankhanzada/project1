import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/constants.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_items_list_screen.dart';

class DriverCategoryScreen extends StatelessWidget {
  const DriverCategoryScreen({super.key});

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
                itemCount: 20,
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
                                      DriverItemsListScreen()));
                        },
                        child: Container(
                          height: 150,
                          width: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Constants.logoImage)),
                            color: AppColors.white.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Organic Ketchup',
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
