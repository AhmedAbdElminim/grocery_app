import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/controllers/prouduct_details_controller/product_detail_cubit.dart';
import 'package:grocery_app/controllers/prouduct_details_controller/product_detail_states.dart';
import 'package:grocery_app/features/product_details/product_details_screen_argument.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../shared/consts/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);
  static const String productDetailsScreenId = 'ProductDetailsScreenId';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color color = isDark ? Colors.white : Colors.black;
    final args = ModalRoute.of(context)!.settings.arguments
        as ProductDetailsScreenArgument;
    return BlocProvider(
      create: (context) => ProductDetailCubit(),
      child: BlocConsumer<ProductDetailCubit, ProductDetailsStates>(
        listener: (context, state) {
          if (state is AddToCartSuccessInProductDetailScreenState) {
            Fluttertoast.showToast(
                msg: 'Product Added To Cart Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is AddWishListSuccessInProductDetailScreenState) {
            Fluttertoast.showToast(
                msg: 'Product Added TO WishList Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = ProductDetailCubit.get(context);
          //cubit.price = args.productModel.price;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            body: Column(
              children: [
                FancyShimmerImage(
                  imageUrl: args.productModel.productImage,
                  height: screenHeight * .4,
                  width: screenWidth,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      defaultText(
                          text: args.productModel.productName,
                          fontSize: 22,
                          fontColor: color,
                          fontWeight: FontWeight.bold),
                      InkWell(
                        onTap: () {
                          cubit.addToWishList(args.productModel);
                        },
                        child: const Icon(IconlyLight.heart),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '\$ ${args.productModel.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: '/${args.productModel.measureUnit}',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                              child: defaultText(
                                  text: 'Free delivery',
                                  fontColor: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.red,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          cubit.changeQuantity('-', args.productModel.price);
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
                    const SizedBox(
                      width: 5,
                    ),
                    defaultText(
                        text: '${cubit.quantity}',
                        fontSize: 17,
                        fontColor: color),
                    const SizedBox(
                      width: 5,
                    ),
                    Card(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          cubit.changeQuantity('+', args.productModel.price);
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
                ),
                const Spacer(),
                Container(
                  color: isDark ? Colors.blueGrey : const Color(0xFFF2FDFD),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultText(
                                text: 'Total',
                                fontSize: 22,
                                fontColor: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    '\$ ${cubit.price == 0 ? args.productModel.price : cubit.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '/${args.productModel.measureUnit}',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        state is AddToCartLoadingInProductDetailScreenState
                            ? defaultLoading()
                            : SizedBox(
                                height: 50,
                                child: Card(
                                  color: Colors.green,
                                  child: InkWell(
                                    onTap: () {
                                      cubit.addToCart(ProductModel(
                                          productName:
                                              args.productModel.productName,
                                          productImage:
                                              args.productModel.productImage,
                                          productCategory:
                                              args.productModel.productCategory,
                                          isSale: args.productModel.isSale,
                                          price: cubit.price == 0
                                              ? args.productModel.price
                                              : cubit.price,
                                          measureUnit:
                                              args.productModel.measureUnit,
                                          productId:
                                              args.productModel.productId,
                                          quantity: cubit.quantity));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                          child: defaultText(
                                              text: 'Add to cart',
                                              fontColor: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
