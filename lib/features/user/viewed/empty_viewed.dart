import 'package:flutter/material.dart';
import 'package:grocery_app/features/all_products/all_products_screen.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../product_details/product_details_screen.dart';

class EmptyViewedScreen extends StatelessWidget {
  const EmptyViewedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/history.png',
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 40,
                ),
                defaultText(
                    text: 'Whoops!',
                    fontSize: 22,
                    fontColor: Colors.orange,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
                defaultText(
                  text: 'Your history is empty',
                  fontSize: 17,
                  fontColor: Colors.blue.withOpacity(.7),
                ),
                const SizedBox(
                  height: 10,
                ),
                defaultText(
                  text: 'No products has been viewed yet!',
                  fontSize: 17,
                  fontColor: Colors.blue.withOpacity(.7),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        defaultNavigation(
                            context, AllProductsScreen.allProductsScreenId);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: Text(
                          'Explore Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
