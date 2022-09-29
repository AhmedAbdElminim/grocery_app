import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../shared/consts/app_strings.dart';

class BannerComponent extends StatelessWidget {
  const BannerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.33,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            AppStrings.offerImages[index],
            fit: BoxFit.fill,
          );
        },
        autoplay: true,
        itemCount: AppStrings.offerImages.length,
        pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                color: Colors.white, activeColor: Colors.red)),
      ),
    );
  }
}
