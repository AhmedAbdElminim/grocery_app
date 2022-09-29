import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../../models/order_model.dart';
import '../../../shared/consts/constants.dart';

class FullOrderScreen extends StatelessWidget {
  const FullOrderScreen({Key? key, required this.orderList}) : super(key: key);
  final List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final Color color = isDark ? Colors.white : Colors.black;
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
        title: Text('Your orders (${orderList.length})'),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FancyShimmerImage(
                imageUrl: orderList[index].orderImage,
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
                      text:
                          '${orderList[index].productName} ${orderList[index].quantity}X',
                      fontSize: 20,
                      fontColor: color,
                      fontWeight: FontWeight.w600),
                  const SizedBox(
                    height: 5,
                  ),
                  defaultText(
                      text: 'Paid: \$${orderList[index].totalPrice}',
                      fontSize: 14,
                      fontColor: Colors.grey),
                ],
              ),
              const Spacer(),
              defaultText(
                  text: orderList[index].orderDate,
                  fontSize: 20,
                  fontColor: color),
            ],
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: orderList.length,
      ),
    );
  }
}
