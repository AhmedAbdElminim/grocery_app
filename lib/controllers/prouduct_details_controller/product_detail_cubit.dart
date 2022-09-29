import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/home_controller/home_states.dart';
import 'package:grocery_app/controllers/prouduct_details_controller/product_detail_states.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/shared/consts/constants.dart';

class ProductDetailCubit extends Cubit<ProductDetailsStates> {
  ProductDetailCubit() : super(ProductDetailInitialState());
  static ProductDetailCubit get(context) => BlocProvider.of(context);
  int quantity = 1;
  double price = 0;
  Future addToCart(ProductModel productModel) async {
    try {
      emit(AddToCartLoadingInProductDetailScreenState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('cart')
          .doc(productModel.productId)
          .set(productModel.toJson())
          .then((value) {
        emit(AddToCartSuccessInProductDetailScreenState());
      });
    } catch (error) {
      emit(AddToCartErrorInProductDetailScreenState(error.toString()));
    }
  }

  Future addToWishList(ProductModel productModel) async {
    try {
      emit(AddToWishListLoadingInProductDetailScreenState());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('wish')
          .doc(productModel.productId)
          .set(productModel.toJson())
          .then((value) {
        emit(AddWishListSuccessInProductDetailScreenState());
      });
    } catch (error) {
      emit(AddWishListErrorInProductDetailScreenState(error.toString()));
    }
  }

  void changeQuantity(String operation, double fixedPrice) {
    price = 0;
    if (operation == '+') {
      quantity++;

      changeTotalPrice(fixedPrice);
      print(price);
      emit(ChangeQuantityInProductDetailScreenState());
    } else {
      if (quantity > 1) {
        quantity--;

        changeTotalPrice(fixedPrice);
        print(price);
        emit(ChangeQuantityInProductDetailScreenState());
      }
    }
  }

  void changeTotalPrice(double x) {
    price = x * quantity;
    emit(ChangeTotalPriceInProductDetailScreenState());
  }
}
