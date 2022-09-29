import 'package:flutter/material.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../shared/consts/constants.dart';
import 'category_products_screen.dart';
import 'empty_category_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget(
      {required this.categoryName,
      required this.categoryImagePath,
      required this.categoryColor,
      Key? key})
      : super(key: key);
  final String categoryName;
  final String categoryImagePath;
  final Color categoryColor;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        defaultNavigation(
            context, CategoryProductsScreen.categoryProductsScreenId,
            args: CategoryProductsScreenArgument(title: categoryName));
      },
      child: Container(
        decoration: BoxDecoration(
            color: categoryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: categoryColor.withOpacity(.7), width: 2)),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: screenWidth * .4,
              width: screenWidth * .4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(categoryImagePath), fit: BoxFit.fill)),
            ),
            const SizedBox(
              height: 10,
            ),
            defaultText(
                text: categoryName,
                fontSize: 18,
                fontColor: isDark ? Colors.white : Colors.black),
          ],
        ),
      ),
    );
  }
}
