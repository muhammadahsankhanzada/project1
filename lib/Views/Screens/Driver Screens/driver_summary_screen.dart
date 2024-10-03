import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/Driver%20Screens/driver_shops_list_screen.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class DriverSummaryScreen extends StatelessWidget {
  const DriverSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> productNames = [
      'Organic Ketchup',
      'Almond Butter',
      'Coconut Oil',
      'Quinoa',
      'Dark Chocolate',
      'Oat Milk',
      'Avocado Oil',
      'Chia Seeds',
      'Maple Syrup',
      'Brown Rice',
    ];
    List<int> productQuantities = [
      2, // Organic Ketchup
      1, // Almond Butter
      3, // Coconut Oil
      1, // Quinoa
      5, // Dark Chocolate
      4, // Oat Milk
      2, // Avocado Oil
      6, // Chia Seeds
      1, // Maple Syrup
      3, // Brown Rice
    ];
    List<double> productPrices = [
      250.0, // Organic Ketchup
      500.0, // Almond Butter
      300.0, // Coconut Oil
      400.0, // Quinoa
      150.0, // Dark Chocolate
      200.0, // Oat Milk
      450.0, // Avocado Oil
      100.0, // Chia Seeds
      350.0, // Maple Syrup
      150.0, // Brown Rice
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
          title: Text(
            'Summary',
            style: AppTextStyles.nameHeadingTextStyle(),
          ),
          centerTitle: true,
          backgroundColor: AppColors.green),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                'Order Summary',
                style: AppTextStyles.mainHeadingTextStyle(),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items',
                    style: AppTextStyles.nameHeadingTextStyle(),
                  ),
                  Text(
                    'Quantity',
                    style: AppTextStyles.nameHeadingTextStyle(),
                  ),
                  Text(
                    'Price',
                    style: AppTextStyles.nameHeadingTextStyle(),
                  ),
                ],
              ),
              Divider(
                color: AppColors.black,
              ),
              for (int i = 0; i < productQuantities.length; i++)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        productNames[i],
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'x${productQuantities[i]}',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Rs. ${productPrices[i]}',
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              Divider(
                color: AppColors.black,
              ),
              Row(
                children: [
                  Text(
                    'Total Quantity',
                    style:
                        AppTextStyles.belowMainHeadingTextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    'x26',
                    style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Total Price',
                    style:
                        AppTextStyles.belowMainHeadingTextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    '5000',
                    style: AppTextStyles.nameHeadingTextStyle(size: 18),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: Lottie.network(
                  'https://lottie.host/ccbbf6ae-e12e-4513-b725-e4e771264379/rtPobWdST1.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Lottie.network(
                  'https://lottie.host/7cf93999-5780-4622-aaae-3a76cbf96987/i1oZrYCLlU.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Waiting for Approval...',
                  style: AppTextStyles.belowMainHeadingTextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UniversalButton(
                      buttonWidth: 150,
                      title: 'Start trip',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverShopsListScreen()));
                      }),
                  UniversalButton(
                      buttonColor: AppColors.red.shade300,
                      buttonWidth: 150,
                      title: 'Cancel',
                      ontap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
