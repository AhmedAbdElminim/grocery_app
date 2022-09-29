import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/wishlist_controller/wishlist_states.dart';

import '../../models/product_model.dart';
import '../../shared/consts/constants.dart';

class WishListCubit extends Cubit<WishListStates> {
  WishListCubit() : super(WishListInitialStates());
  static WishListCubit get(context) => BlocProvider.of(context);
  List<ProductModel> wishListProductsList = [];
  Future getWishListProducts() async {
    try {
      emit(GetWishListProductsLoadingStates());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(token)
          .collection('wish')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          wishListProductsList.add(ProductModel.fromJson(element.data()));
        });
        emit(GetWishListProductsSuccessStates());
      });
    } catch (error) {
      emit(GetWishListProductsErrorStates(error.toString()));
    }
  }

  Future clearWishList() async {
    emit(ClearWishListLoadingStates());
    wishListProductsList.clear();

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .collection('wish');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    emit(ClearWishListStates());
  }
}
