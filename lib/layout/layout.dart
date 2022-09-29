import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../features/cart/cart_screen.dart';
import '../features/categories/categories_screen.dart';
import '../features/home/home_screen.dart';
import '../features/user/user_screen.dart';

class LayOut extends StatefulWidget {
  const LayOut({Key? key}) : super(key: key);
  static const String layOutScreenId='LayOutScreenId';

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    UserScreen(),
  ];
  List<String> titles = [
    'Home',
    'Categories',
    'Cart',
    'User',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon:
                  Icon(_currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(_currentIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: ''),
          BottomNavigationBarItem(
              icon: Badge(
                  badgeContent: const Text('0'),
                  child: Icon(
                      _currentIndex == 2 ? IconlyBold.buy : IconlyLight.buy)),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                  _currentIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: ''),
        ],
      ),
    );
  }
}

