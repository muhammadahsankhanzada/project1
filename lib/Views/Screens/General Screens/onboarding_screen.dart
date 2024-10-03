import 'package:flutter/material.dart';
import 'package:project1/Utils/colors.dart';
import 'package:project1/Utils/onboarding_items_list.dart';
import 'package:project1/Utils/text_styles.dart';
import 'package:project1/Views/Screens/General%20Screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                itemCount: onboardingItemsListContent.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            width: double.infinity,
                            height: 300,
                            onboardingItemsListContent[index].image),
                        SizedBox(height: 30),
                        Text(
                          textAlign: TextAlign.center,
                          onboardingItemsListContent[index].title,
                          style: AppTextStyles.onboardingTitleTextStyle(),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          onboardingItemsListContent[index].subtitle,
                          style: AppTextStyles.onboardingDescriptionTextStyle(),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingItemsListContent.length,
                (index) => buildDots(index, context),
              ),
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              if (currentIndex == onboardingItemsListContent.length - 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
              _pageController.nextPage(
                  duration: Duration(microseconds: 100),
                  curve: Curves.bounceInOut);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  currentIndex == onboardingItemsListContent.length - 1
                      ? 'Start'
                      : 'Next',
                  style: AppTextStyles.onboardingTitleTextStyle(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      height: 8,
      width: currentIndex == index ? 18 : 7,
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
