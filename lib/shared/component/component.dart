import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/shared/consts/constants.dart';

Widget defaultText(
        {required String text,
        required double fontSize,
        required Color fontColor,
        FontWeight fontWeight = FontWeight.normal}) =>
    Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
          fontSize: fontSize, color: fontColor, fontWeight: fontWeight),
    );

Widget defaultTextFormField(
        {required TextEditingController controller,
        bool isPassword = false,
        required String hintText,
        void Function()? visiblePassFun,
        required TextInputType keyboardType,
        required String? Function(String?)? validator}) =>
    TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: visiblePassFun, icon: const Icon(Icons.visibility))
              : null,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ));
Future navigateAndFinish(context, String screenId, {Object? args}) =>
    Navigator.pushNamedAndRemoveUntil(context, screenId, (route) => false,
        arguments: args);
Future defaultNavigation(context, String screenId, {Object? args}) =>
    Navigator.pushNamed(context, screenId, arguments: args);
Widget defaultLoading() => const Center(
      child: SpinKitFadingCube(color: Colors.grey),
    );

void showToAst({required String msg, required bool isError}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);



