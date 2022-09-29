import 'package:flutter/material.dart';
import 'package:grocery_app/models/product_model.dart';

import '../../shared/consts/constants.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../product_details/product_details_screen.dart';
import '../product_details/product_details_screen_argument.dart';

class SaleScreenItem extends StatelessWidget {
  const SaleScreenItem(
      {Key? key,
      required this.productModel,
      required this.wishFunction,
      required this.cartFunction})
      : super(key: key);
  final ProductModel productModel;
  final Future<void> Function(ProductModel) wishFunction;
  final Future<void> Function(ProductModel) cartFunction;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Color color = isDark ? Colors.white : Colors.black;
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          recentViewed.add(productModel);
          defaultNavigation(
              context, ProductDetailsScreen.productDetailsScreenId,
              args: ProductDetailsScreenArgument(productModel: productModel));
        },
        child: Container(
          height: screenWidth * .2,
          width: screenWidth * .4,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FancyShimmerImage(
                      imageUrl: productModel.productImage,
                      height: screenWidth * .22,
                      width: screenWidth * .22,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                            text: productModel.measureUnit,
                            fontSize: 22,
                            fontColor: color,
                            fontWeight: FontWeight.bold),
                        Row(
                          children: [
                            InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  cartFunction(productModel);
                                },
                                child: const Icon(IconlyLight.bag2)),
                            InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  wishFunction(productModel);
                                },
                                child: const Icon(IconlyLight.heart)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              // const Spacer(),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: '\$${productModel.price}  ',
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\$${productModel.price + 3}',
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 4,
              ),
              defaultText(
                  text: productModel.productName,
                  fontSize: 18,
                  fontColor: color),
            ],
          ),
        ),
      ),
    );
  }
}
