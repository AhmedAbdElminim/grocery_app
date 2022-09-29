import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/controllers/auth_controller/auth_cubit.dart';
import 'package:grocery_app/controllers/home_controller/home_cubit.dart';
import 'package:grocery_app/controllers/home_controller/home_states.dart';
import 'package:grocery_app/features/home/sale_screen.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../shared/consts/constants.dart';
import '../all_products/all_products_screen.dart';
import 'banner_component.dart';

import 'onsale_item_component.dart';
import 'our_products_item_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final Color color = isDark ? Colors.white : Colors.black;

    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            Fluttertoast.showToast(
                msg: 'Product Added TO Cart Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          if (state is AddToWishListSuccessState) {
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
          // context.read<AuthCubit>().getUserData(uId: token);
          // print('the value of user model is $userModel');

          var cubit = HomeCubit.get(context);
          return state is GetDataLoadingState
              ? defaultLoading()
              : ListView(
                  children: [
                    const BannerComponent(),
                    Visibility(
                      visible: cubit.saleProductsList.isNotEmpty ? true : false,
                      child: Center(
                        child: TextButton(
                            onPressed: () {
                              defaultNavigation(
                                  context, SaleScreen.saleScreenId);
                            },
                            child: defaultText(
                                text: 'View all',
                                fontSize: 20,
                                fontColor: Colors.blue)),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Visibility(
                      visible: cubit.saleProductsList.isNotEmpty ? true : false,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                defaultText(
                                    text: 'ON SALE',
                                    fontSize: 22,
                                    fontColor: Colors.red,
                                    fontWeight: FontWeight.bold),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  IconlyLight.discount,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: SizedBox(
                              height: screenWidth * 0.45,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    OnSaleItemComponent(
                                  productModel: cubit.saleProductsList[index],
                                  wishFunction: cubit.addProductsToWishList,
                                  cartFunction: cubit.addProductsToCart,
                                ),
                                itemCount: cubit.saleProductsList.length,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        children: [
                          defaultText(
                              text: 'Our Products',
                              fontSize: 22,
                              fontColor: color,
                              fontWeight: FontWeight.bold),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                defaultNavigation(
                                  context,
                                  AllProductsScreen.allProductsScreenId,
                                );
                              },
                              child: defaultText(
                                  text: 'View all',
                                  fontSize: 18,
                                  fontColor: Colors.blue))
                        ],
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      crossAxisCount: 2,
                      childAspectRatio: 240 / 250,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(
                          cubit.allProductsList.length,
                          (index) => OurProductsItemComponent(
                                productModel: cubit.allProductsList[index],
                                wishFunction: cubit.addProductsToWishList,
                              )),
                    )
                  ],
                );
        },
      ),
    );
  }
}
