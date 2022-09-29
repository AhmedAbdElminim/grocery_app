import 'package:flutter/cupertino.dart';
import 'package:grocery_app/features/auth/frogot_password/forgot_password_screen.dart';
import 'package:grocery_app/features/auth/login/login_screen.dart';
import 'package:grocery_app/features/auth/register/register_screen.dart';
import 'package:grocery_app/features/onboarding/onboarding_screen.dart';
import 'package:grocery_app/features/splash_screen/splash_screen.dart';
import 'package:grocery_app/features/user/order/order_screen.dart';
import 'package:grocery_app/layout/layout.dart';

import '../../features/all_products/all_products_screen.dart';
import '../../features/categories/category_products_screen.dart';
import '../../features/home/sale_screen.dart';
import '../../features/product_details/product_details_screen.dart';
import '../../features/user/viewed/viewed_screen.dart';
import '../../features/user/wish_list/wish_list_screen.dart';

class RoutesManager {
  static Map<String, Widget Function(BuildContext)> routs = {
    OnBoardingScreen.onBoardingScreenId: (context) => const OnBoardingScreen(),
    LoginScreen.loginScreenId: (context) => const LoginScreen(),
    RegisterScreen.registerScreenId: (context) => const RegisterScreen(),
    ForgotPasswordScreen.forgotPasswordScreenId: (context) =>
        const ForgotPasswordScreen(),
    LayOut.layOutScreenId: (context) => const LayOut(),
    SaleScreen.saleScreenId: (context) => const SaleScreen(),
    AllProductsScreen.allProductsScreenId: (context) =>
        const AllProductsScreen(),
    ProductDetailsScreen.productDetailsScreenId: (context) =>
        const ProductDetailsScreen(),
    CategoryProductsScreen.categoryProductsScreenId: (context) =>
        const CategoryProductsScreen(),
    SplashScreen.splashScreenId: (context) => const SplashScreen(),
    OrderScreen.orderScreenId: (context) => const OrderScreen(),
    WishListScreen.wishListScreenId: (context) => const WishListScreen(),
    ViewedScreen.viewedScreenId: (context) => const ViewedScreen(),
  };
}
