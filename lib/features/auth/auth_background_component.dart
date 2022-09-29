import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class AuthBackgroundComponent extends StatelessWidget {
  AuthBackgroundComponent({Key? key}) : super(key: key);
  final List<String> imagesPath = [
    'assets/images/landing/buy-on-laptop.jpg',
    'assets/images/landing/buy-through.png',
    'assets/images/landing/buyfood.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/store.jpg',
    'assets/images/landing/vergtablebg.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            imagesPath[index],
            height: screenHeight,
            width: screenWidth,
            fit: BoxFit.fill,
          );
        },
        autoplay: true,
        itemCount: imagesPath.length,
      ),
    );
  }
}
