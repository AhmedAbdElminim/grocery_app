import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/shared/consts/constants.dart';

import '../../models/order_model.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialStates());
  static OrderCubit get(context) => BlocProvider.of(context);
  List<OrderModel> orderList = [];
  Future getOrders() async {
    try {
      emit(GetOrdersLoadingStates());
      await FirebaseFirestore.instance.collection('orders').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['orderOwnerUid'] == userModel!.uId) {
            orderList.add(OrderModel.fromJson(element.data()!));
          }
        });
        emit(GetOrdersSuccessStates());
      });
    } catch (error) {
      emit(GetOrdersErrorStates(error.toString()));
    }
  }
}
