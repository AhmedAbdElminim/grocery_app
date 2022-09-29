import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../models/product_model.dart';
import '../../../shared/component/component.dart';
import '../../../shared/consts/constants.dart';


class WishListItemComponent extends StatelessWidget {
  const WishListItemComponent({Key? key, required this.productModel}) : super(key: key);
final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color color = isDark ? Colors.white : Colors.black;
    return Container(
      decoration:
          BoxDecoration(
            borderRadius: BorderRadius.circular(20),

              border: Border.all(color:isDark?Colors.white: Colors.grey.withOpacity(.5), width: 2)),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FancyShimmerImage(
            imageUrl:productModel.productImage,
            height: screenWidth * .22,
            width: screenWidth* .22,
          ),
          const SizedBox(width: 10,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(children: [
              InkWell(onTap: (){},child: const Icon(IconlyLight.bag),),
              const SizedBox(width: 5,),
              InkWell(onTap: (){},child: const Icon(IconlyLight.heart),),
            ],),
               const SizedBox(height: 10,),
               defaultText(text: productModel.productName, fontSize: 17, fontColor: color),
              const SizedBox(height: 10,),
               defaultText(text: '\$ ${productModel.price}', fontSize: 17, fontColor: color,fontWeight: FontWeight.bold),
          ],))

        ],
      ),
    );
  }
}
