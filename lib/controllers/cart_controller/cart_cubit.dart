import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/models/order_model.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/shared/consts/constants.dart';
import 'package:intl/intl.dart';

import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialStates());
  static CartCubit get(context) => BlocProvider.of(context);
  List<ProductModel> cartList = [];
  List<int> quantity = [];
  List<double> newPrice = [];
  double totalSum = 0;
  Future getCartProducts() async {
    try {
      totalSum = 0;
      emit(GetCartProductLoadingStates());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('cart')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          cartList.add(ProductModel.fromJson(element.data()));
          quantity.add(1);
          totalSum += element.data()['price'];
          newPrice.add(element.data()['price']);
        });
        emit(GetCartProductSuccessStates());
      });
    } catch (error) {
      emit(GetCartProductErrorStates(error.toString()));
    }
  }

  Future<void> calculatePriceForOneItem(int index) async {
    newPrice[index] = quantity[index] * cartList[index].price;
  }

  void calculateTotalPrice() {
    totalSum = 0;
    for (int i = 0; i < newPrice.length; i++) {
      totalSum += newPrice[i];
    }
  }

  Future<void> changeQuantity(String operation, int index) async {
    if (operation == '+') {
      quantity[index]++;
      calculatePriceForOneItem(index);
      calculateTotalPrice();
      emit(ChangeQuantityStateStates());
    } else {
      if (quantity[index] > 1) {
        quantity[index]--;
        calculatePriceForOneItem(index);
        calculateTotalPrice();
        emit(ChangeQuantityStateStates());
      }
    }
  }

  Future<void> makeOrder(List<ProductModel> list) async {
    try {
      emit(MakeOrderLoadingStates());
      for (int i = 0; i < list.length; i++) {
        OrderModel orderModel = OrderModel(
            quantity: quantity[i],
            orderImage: list[i].productImage,
            totalPrice: newPrice[i],
            orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            orderOwnerName: userModel!.name,
            addressShipping: userModel!.shippingAddress,
            productName: list[i].productName, orderOwnerUid: userModel!.uId);
        await FirebaseFirestore.instance
            .collection('orders')
            .doc()
            .set(orderModel.toJson())
            .then((value) {});
      }
      clearCartList();
      emit(MakeOrderSuccessStates());
    } catch (error) {
      emit(MakeOrderErrorStates(error.toString()));
    }
  }

  Future clearCartList() async {
    emit(ClearCartListLoadingStates());
    cartList.clear();

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .collection('cart');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(ClearCartListStates());
  }
}
