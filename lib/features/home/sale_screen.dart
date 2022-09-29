import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/controllers/home_controller/home_cubit.dart';
import 'package:grocery_app/controllers/home_controller/home_states.dart';
import 'package:grocery_app/features/home/sale_screen_item.dart';

import '../../shared/component/component.dart';
import '../../shared/consts/constants.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({Key? key}) : super(key: key);
  static const String saleScreenId = 'SaleScreenId';
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
              title: const Text('Sales Product'),
            ),
            body: state is GetDataLoadingState
                ? defaultLoading()
                : GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisCount: 2,
                    childAspectRatio: 240 / 250,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                        cubit.saleProductsList.length,
                        (index) => SaleScreenItem(
                              productModel: cubit.saleProductsList[index],
                              wishFunction: cubit.addProductsToWishList,
                              cartFunction: cubit.addProductsToCart,
                            )),
                  ),
          );
        },
      ),
    );
  }
}
