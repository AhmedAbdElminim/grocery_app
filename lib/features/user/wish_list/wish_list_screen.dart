import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/controllers/wishlist_controller/wishlist_cubit.dart';
import 'package:grocery_app/controllers/wishlist_controller/wishlist_states.dart';
import 'package:grocery_app/features/user/wish_list/wish_list_item_component.dart';

import '../../../shared/component/component.dart';
import '../../../shared/consts/constants.dart';
import 'empty_wish_list.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static const String wishListScreenId='WishListScreenId';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit()..getWishListProducts(),
      child: BlocConsumer<WishListCubit, WishListStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WishListCubit.get(context);
          return state is GetWishListProductsLoadingStates
              ? Scaffold(
                  body: defaultLoading(),
                )
              : cubit.wishListProductsList.isEmpty
                  ? const EmptyWishListScreen()
                  : Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        centerTitle: true,
                        title: Text(
                            'Wishlist(${cubit.wishListProductsList.length})'),
                        actions: [
                          state is ClearWishListLoadingStates
                              ? defaultLoading()
                              : IconButton(
                                  onPressed: () {
                                    cubit.clearWishList();
                                  },
                                  icon: Icon(
                                    IconlyLight.delete,
                                    color: isDark ? Colors.white : Colors.black,
                                  ))
                        ],
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          // childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(
                              cubit.wishListProductsList.length,
                              (index) => WishListItemComponent(
                                    productModel:
                                        cubit.wishListProductsList[index],
                                  )),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
