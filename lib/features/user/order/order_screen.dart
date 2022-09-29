import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/order_controller/order_cubit.dart';
import 'package:grocery_app/features/user/order/empty_order_screen.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../../controllers/order_controller/order_states.dart';
import 'full_order_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
static const String orderScreenId='OrderScreenId';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..getOrders(),
      child: BlocConsumer<OrderCubit, OrderStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = OrderCubit.get(context);
          return state is GetOrdersLoadingStates
              ? Scaffold(
                  body: defaultLoading(),
                )
              : cubit.orderList.isEmpty
                  ? const EmptyOrderScreen()
                  :  FullOrderScreen(orderList: cubit.orderList,);
        },
      ),
    );
  }
}
