import 'package:flutter/material.dart';

import '../../shared/consts/app_strings.dart';
import 'category_item_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  final List<Color> categoryColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 230 / 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index) {
            return CategoryItemWidget(
              categoryName: AppStrings.categoryNames[index],
              categoryImagePath: AppStrings.categoryImagePaths[index],
              categoryColor: categoryColors[index],
            );
          }),
        ),
      ),
    );
  }
}
