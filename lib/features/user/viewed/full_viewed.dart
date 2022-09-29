import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../shared/component/component.dart';
import '../../../shared/consts/constants.dart';

class FullViewedScreen extends StatelessWidget {
  const FullViewedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color color = isDark ? Colors.white : Colors.black;

    final recentViewedList = (recentViewed.toSet()).toList();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text('History'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Icon(
                IconlyLight.delete,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          )
        ],
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FancyShimmerImage(
                      imageUrl: recentViewedList[index].productImage,
                      height: screenWidth * .2,
                      width: screenWidth * .2,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                            text: '${recentViewedList[index].productName} 1X',
                            fontSize: 20,
                            fontColor: color,
                            fontWeight: FontWeight.w600),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultText(
                            text: 'Price: \$${recentViewedList[index].price}',
                            fontSize: 14,
                            fontColor: Colors.grey),
                      ],
                    ),
                    const Spacer(),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.green,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: recentViewedList.length),
    );
  }
}
