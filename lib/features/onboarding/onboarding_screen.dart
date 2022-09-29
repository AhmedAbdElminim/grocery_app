import 'package:flutter/material.dart';
import 'package:grocery_app/features/auth/login/login_screen.dart';
import 'package:grocery_app/shared/component/component.dart';
import 'package:grocery_app/shared/consts/app_strings.dart';
import 'package:grocery_app/shared/network/local.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const String onBoardingScreenId = 'OnBoardingScreenId';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController();
  int currentIndex = 0;
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        AppStrings.onBoardingImagePaths[0],
        AppStrings.onBoardingTitlesText[0],
        AppStrings.onBoardingDescriptionText[0]),
    OnBoardingModel(
        AppStrings.onBoardingImagePaths[1],
        AppStrings.onBoardingTitlesText[1],
        AppStrings.onBoardingDescriptionText[1]),
    OnBoardingModel(
        AppStrings.onBoardingImagePaths[2],
        AppStrings.onBoardingTitlesText[2],
        AppStrings.onBoardingDescriptionText[2]),
    OnBoardingModel(
        AppStrings.onBoardingImagePaths[3],
        AppStrings.onBoardingTitlesText[3],
        AppStrings.onBoardingDescriptionText[3]),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true)
                    .then((value) {
                  navigateAndFinish(context, LoginScreen.loginScreenId);
                });
              },
              child: const Text(
                'SKIP',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                if (currentIndex == onBoardingList.length) {
                  // CacheHelper.saveData(key: 'onBoarding', value: true);
                  // navigateAndFinish(context, LoginScreen.loginScreenId);
                }
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    onBoardingList[currentIndex].imagePath,
                    height: screenHeight * .4,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      onBoardingList[currentIndex].title,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      onBoardingList[currentIndex].description,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              itemCount: onBoardingList.length,
            ),
          ),
          SmoothPageIndicator(
              controller: controller, // PageController
              count: onBoardingList.length,
              effect: const WormEffect(dotColor: Colors.green),
              onDotClicked: (index) {}),
          // const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: InkWell(
              onTap: () {
                if (currentIndex != onBoardingList.length - 1) {
                  setState(() {
                    controller.nextPage(
                      duration: const Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  });
                } else {
                  CacheHelper.saveData(key: 'onBoarding', value: true);
                  navigateAndFinish(context, LoginScreen.loginScreenId);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)
                    // border: Border.all(color: Colors.red, width: 2),
                    ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Center(
                      child: defaultText(
                          text: currentIndex != onBoardingList.length - 1
                              ? 'Next'
                              : 'Finish',
                          fontSize: 17,
                          fontColor: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
