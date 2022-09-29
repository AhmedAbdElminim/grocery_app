import 'package:flutter/material.dart';

import '../component/component.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required BuildContext context,
    required String title,
    required String subTitle,
    required Function function,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(title)
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: defaultText(
                      text: 'Cancel', fontSize: 18, fontColor: Colors.cyan)),
              TextButton(
                  onPressed: () {
                    function();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: defaultText(
                      text: 'Ok', fontSize: 18, fontColor: Colors.red)),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required BuildContext context,
    required String subTitle,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('An Error occurred'),
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: defaultText(
                      text: 'Ok', fontSize: 18, fontColor: Colors.cyan)),
            ],
          );
        });
  }
}
