import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../models/product_model.dart';
import '../../shared/consts/constants.dart';
import 'full_category_item_component.dart';

class FullCategoryScreen extends StatelessWidget {
  const FullCategoryScreen(
      {Key? key, required this.productModelList, required this.title})
      : super(key: key);
  final List<ProductModel> productModelList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
              color: isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        title: Text(title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {},
                child: Icon(IconlyLight.bag,
                    color: isDark ? Colors.white : Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {},
                child: Icon(IconlyLight.heart,
                    color: isDark ? Colors.white : Colors.black)),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisCount: 2,
        childAspectRatio: 230 / 290,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: List.generate(
            productModelList.length,
            (index) => CategoryProductItemComponent(
                productModel: productModelList[index])),
      ),
    );
  }
}
