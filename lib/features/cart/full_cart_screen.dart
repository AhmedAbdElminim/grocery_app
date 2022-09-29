import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../models/product_model.dart';
import '../../shared/component/component.dart';
import '../../shared/consts/constants.dart';

class FullCartScreen extends StatelessWidget {
  const FullCartScreen(
      {Key? key,
      required this.cartProductModelList,
      required this.quantity,
      required this.newPrices,
      required this.addFunction,
      required this.minusFunction,
      required this.totalPrice, required this.makeOrderFun, required this.clearCart})
      : super(key: key);
  final double totalPrice;
  final List<ProductModel> cartProductModelList;
  final List<int> quantity;
  final List<double> newPrices;
  final Future<void> Function(String, int) addFunction;
  final Future<void> Function(String, int) minusFunction;
  final Future<void> Function() clearCart;
  final Future<void> Function(List<ProductModel>) makeOrderFun;


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final Color color = isDark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart(${cartProductModelList.length})'),
        actions: [
          IconButton(onPressed: () {clearCart();}, icon: const Icon(IconlyLight.delete,color: Colors.black,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Colors.green,
                  child: InkWell(
                    onTap: () {
                      makeOrderFun(cartProductModelList);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                          child: defaultText(
                              text: 'Order Now',
                              fontColor: Colors.white,
                              fontSize: 17)),
                    ),
                  ),
                ),
                defaultText(
                    text: 'total: \$$totalPrice',
                    fontSize: 17,
                    fontColor: isDark ? Colors.white : Colors.black)
              ],
            ),
            Flexible(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FancyShimmerImage(
                      imageUrl: cartProductModelList[index].productImage,
                      height: screenWidth * .22,
                      width: screenWidth * .22,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        defaultText(
                            text: cartProductModelList[index].productName,
                            fontSize: 17,
                            fontColor: color),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.red,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  minusFunction('-', index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            defaultText(
                                text: '${quantity[index]}',
                                fontSize: 17,
                                fontColor: color),
                            Card(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  addFunction('+', index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            IconlyLight.heart,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultText(
                            text: '\$${newPrices[index]}',
                            fontSize: 17,
                            fontColor: color,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ],
                ),
              ),
              itemCount: cartProductModelList.length,
            )),
          ],
        ),
      ),
    );
  }
}
