import 'package:flutter/material.dart';
import 'package:project1/Models/products_dummy_data_model.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Widgets/custom_snackbar.dart';
import 'package:project1/Views/Widgets/universal_button.dart';

class ManagerPendingRequestDetailsScreen extends StatelessWidget {
  const ManagerPendingRequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ahsan Store',
          style: AppTextStyles.nameHeadingTextStyle(),
        ),
        centerTitle: true,
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Request Summary',
                  style: AppTextStyles.mainHeadingTextStyle(),
                ),
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
              for (int i = 0; i < productsDummyDataModelContent.length; i++)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        productsDummyDataModelContent[i].name,
                        style: AppTextStyles.belowMainHeadingTextStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'x${productsDummyDataModelContent[i].quantity}',
                        style: AppTextStyles.nameHeadingTextStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Rs. ${productsDummyDataModelContent[i].price}',
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UniversalButton(
                    title: 'Approve',
                    buttonWidth: 150,
                    ontap: () {
                      customSnackbar(context, 'Request Approved');
                    },
                  ),
                  UniversalButton(
                    title: 'Disapprove',
                    buttonWidth: 150,
                    buttonColor: AppColors.red.shade400,
                    ontap: () {
                      customSnackbar(context, 'Request Disapproved');
                    },
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}