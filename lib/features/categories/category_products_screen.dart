import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/controllers/category_controller/category_cubit.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../controllers/category_controller/category_states.dart';
import 'empty_category_screen.dart';
import 'full_category_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);
  static const String categoryProductsScreenId = 'CategoryProductsScreenId';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as CategoryProductsScreenArgument;
    return BlocProvider(
      create: (context) =>
          CategoryCubit()..getCategoryData(categoryName: args.title),
      child: BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          return state is GetCategoryProductsLoadingStates
              ?  Scaffold(
                  body: defaultLoading(),
                )
              : cubit.categoryList.isEmpty
                  ? const EmptyCategoryScreen()
                  : FullCategoryScreen(
                      productModelList: cubit.categoryList,
                      title: args.title,
                    );
        },
      ),
    );
  }
}

class CategoryProductsScreenArgument {
  final String title;
  CategoryProductsScreenArgument({required this.title});
}
