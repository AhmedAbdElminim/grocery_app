import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import '../../shared/component/component.dart';
import '../../shared/consts/constants.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<ProductModel> saleProductsList = [];
  List<ProductModel> allProductsList = [];
  Map<String, bool> inCartList = {};
  Future getProducts() async {
    try {
      emit(GetDataLoadingState());
      FirebaseFirestore.instance.collection('products').get().then((value) {
        value.docs.forEach((element) async {
          allProductsList.add(ProductModel.fromJson(element.data()));

          if (element.data()['isSale']) {
            saleProductsList.add(ProductModel.fromJson(element.data()));
          }
        });

        emit(GetDataSuccessState());
      });
    } catch (error) {
      emit(GetDataErrorState(error.toString()));
    }
  }

  Future inCartListFunc() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        inCartList.addAll({"${element.data()['productId']}": true});
      });
    });
  }

  Future addProductsToCart(ProductModel productModel) async {
    try {
      emit(AddToCartLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('cart')
          .doc(productModel.productId)
          .set(productModel.toJson())
          .then((value) {
        emit(AddToCartSuccessState());
      });
    } catch (error) {
      emit(AddToCartErrorState(error.toString()));
    }
  }

  Future addProductsToWishList(ProductModel productModel) async {
    try {
      emit(AddToWishListLoadingState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('wish')
          .doc(productModel.productId)
          .set(productModel.toJson())
          .then((value) {
        emit(AddToWishListSuccessState());
      });
    } catch (error) {
      emit(AddToWishListErrorState(error.toString()));
    }
  }
}
