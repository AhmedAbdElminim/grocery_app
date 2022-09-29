import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../models/product_model.dart';
import '../../shared/consts/constants.dart';
import '../product_details/product_details_screen.dart';
import '../product_details/product_details_screen_argument.dart';

class AllProductItemComponent extends StatelessWidget {
  const AllProductItemComponent(
      {Key? key,
      required this.productModel,
      required this.wishFunc,
      required this.cartFunc})
      : super(key: key);
  final ProductModel productModel;
  final Future<void> Function(ProductModel) wishFunc;
  final Future<void> Function(ProductModel) cartFunc;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final Color color = isDark ? Colors.white : Colors.black;

    return Container(
      height: screenWidth * .5,
      width: screenWidth * .4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Material(
              color: Theme.of(context).cardColor,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                onTap: () {
                  recentViewed.add(productModel);
                  defaultNavigation(
                      context, ProductDetailsScreen.productDetailsScreenId,
                      args: ProductDetailsScreenArgument(
                          productModel: productModel));
                },
                child: Container(
                  //height: screenWidth * .5,
                  //width: screenWidth * .4,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: FancyShimmerImage(
                          imageUrl: productModel.productImage,
                          height: screenWidth * .22,
                          width: screenWidth * .22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              productModel.productName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                            InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  wishFunc(productModel);
                                },
                                child: const Icon(IconlyLight.heart)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            defaultText(
                                text: '\$${productModel.price}',
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontColor: Colors.green),
                            const Spacer(),
                            defaultText(
                                text: productModel.measureUnit,
                                fontSize: 17,
                                fontColor: color,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              onTap: () {
                cartFunc(productModel);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(child: Text('Add to cart')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
