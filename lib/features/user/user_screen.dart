import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/features/auth/login/login_screen.dart';
import 'package:grocery_app/features/user/viewed/viewed_screen.dart';
import 'package:grocery_app/features/user/wish_list/wish_list_screen.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/shared/component/component.dart';
import 'package:grocery_app/shared/consts/constants.dart';
import 'package:grocery_app/shared/network/local.dart';
import '../../shared/services/global_method.dart';
import 'dark_theme_switch_component.dart';
import 'order/order_screen.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Row(
            children: [
              const Text(
                'Hi, ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.cyan),
              ),
              Text(
                userModel!.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          subtitle: Text(userModel!.email),
        ),
        const Divider(
          thickness: 2,
        ),
        ListTile(
          leading: const Icon(IconlyLight.profile),
          title: const Text('Address'),
          subtitle: Text(userModel!.shippingAddress),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            _showAddressDialog(context);
          },
        ),
        ListTile(
          leading: const Icon(IconlyLight.bag),
          title: const Text('Orders'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            defaultNavigation(context, OrderScreen.orderScreenId);
          },
        ),
        ListTile(
          leading: const Icon(IconlyLight.heart),
          title: const Text('Wishlist'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            defaultNavigation(context, WishListScreen.wishListScreenId);
          },
        ),
        ListTile(
          leading: const Icon(IconlyLight.show),
          title: const Text('Viewed'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            defaultNavigation(context, ViewedScreen.viewedScreenId);
          },
        ),
        ListTile(
          leading: const Icon(IconlyLight.lock),
          title: const Text('Forget password'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const DarkThemeSwitchComponent(),
        ListTile(
          leading: const Icon(IconlyLight.logout),
          title: const Text('LogOut'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            GlobalMethods.warningDialog(
                context: context,
                title: 'Sign out',
                subTitle: 'Do you wanna sign out?',
                function: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    userModel = null;
                    CacheHelper.removeData(key: 'token').then((value) {
                      navigateAndFinish(context, LoginScreen.loginScreenId);
                    });
                  });
                });
          },
        ),
      ],
    );
  }

  Future<void> _showAddressDialog(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          addressController.text = userModel!.shippingAddress;
          return AlertDialog(
            title: const Text('Update'),
            content: TextFormField(
              maxLines: 5,
              controller: addressController,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userModel!.uId)
                        .update(UserModel(
                                uId: userModel!.uId,
                                name: userModel!.name,
                                email: userModel!.email,
                                shippingAddress: addressController.text)
                            .toJson())
                        .then((value) {
                      userModel = UserModel(
                          uId: token,
                          name: userModel!.name,
                          email: userModel!.email,
                          shippingAddress: addressController.text);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }
}
