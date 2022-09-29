import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/category_controller/category_states.dart';
import 'package:grocery_app/models/product_model.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialStates());
  static CategoryCubit get(context) => BlocProvider.of(context);
  List<ProductModel> categoryList = [];
  Future getCategoryData({required String categoryName}) async {
    try {
      emit(GetCategoryProductsLoadingStates());
      await FirebaseFirestore.instance
          .collection('products')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['productCategory'] == categoryName) {
            categoryList.add(ProductModel.fromJson(element.data()));
          }
        });

        emit(GetCategoryProductsSuccessStates());
      });
    } catch (error) {
      emit(GetCategoryProductsErrorStates(error.toString()));
    }
  }
}
