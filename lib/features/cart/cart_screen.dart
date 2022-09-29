import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/cart_controller/cart_cubit.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../controllers/cart_controller/cart_states.dart';
import 'empty_cart_screen.dart';
import 'full_cart_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          return state is GetCartProductLoadingStates
              ? defaultLoading()
              : cubit.cartList.isEmpty
                  ? const EmptyCartScreen()
                  : FullCartScreen(
                      cartProductModelList: cubit.cartList,
                      quantity: cubit.quantity,
                      newPrices: cubit.newPrice,
                      addFunction: cubit.changeQuantity,
                      minusFunction: cubit.changeQuantity,
                      totalPrice: cubit.totalSum, makeOrderFun:cubit.makeOrder, clearCart: cubit.clearCartList,
                    );
        },
      ),
    );
  }
}
