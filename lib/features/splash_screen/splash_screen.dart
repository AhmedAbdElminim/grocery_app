import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/Material.dart';
import 'package:grocery_app/features/auth/login/login_screen.dart';
import 'package:grocery_app/features/onboarding/onboarding_screen.dart';
import 'package:grocery_app/layout/layout.dart';
import 'package:grocery_app/shared/consts/constants.dart';
import 'package:lottie/lottie.dart';

import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String splashScreenId = 'SplashScreenId';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Lottie.asset(
        'assets/splash/93638-add-to-cart.json',
        //width: 300,
        //height:300,
        //fit: BoxFit.fill,
      ),
      nextScreen: startScreen == OnBoardingScreen.onBoardingScreenId
          ? const OnBoardingScreen()
          : startScreen == LoginScreen.loginScreenId
              ? const LoginScreen()
              : const LayOut(), //const LayOut(),
      backgroundColor: Colors.white,//Colors.blueGrey[900]!,
      duration: 5000,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.leftToRight,
    );
  }
}
