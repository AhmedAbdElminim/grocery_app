import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../controllers/home_controller/home_cubit.dart';
import '../../controllers/home_controller/home_states.dart';
import '../../shared/component/component.dart';
import '../../shared/consts/constants.dart';
import 'all_product_item_component.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);
  static const String allProductsScreenId = 'AllProductsScreenId';
  @override
  Widget build(BuildContext context) {
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
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,
                    color: isDark ? Colors.white : Colors.black),
              ),
              centerTitle: true,
              title: const Text('All Proudcts'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {},
                      child: Icon(IconlyLight.bag,
                          color: isDark ? Colors.white : Colors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {},
                      child: Icon(IconlyLight.heart,
                          color: isDark ? Colors.white : Colors.black)),
                ),
              ],
            ),
            body: state is GetDataLoadingState
                ? defaultLoading()
                : GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 2,
                    childAspectRatio: 230 / 290,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                        cubit.allProductsList.length,
                        (index) => AllProductItemComponent(
                              productModel: cubit.allProductsList[index],
                              wishFunc: cubit.addProductsToWishList,
                              cartFunc: cubit.addProductsToCart,
                            )),
                  ),
          );
        },
      ),
    );
  }
}

class AllProductsScreenArgument {
  final String title;
  AllProductsScreenArgument({required this.title});
}
