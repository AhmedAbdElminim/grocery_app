import 'package:flutter/material.dart';

import '../auth_background_component.dart';
import 'forgot_password_screen_form_component.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static const  String forgotPasswordScreenId='ForgotPasswordScreenId';
  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          AuthBackgroundComponent(),
          Container(height: screenHeight,width: screenWidth,color: Colors.black.withOpacity(.6),),
          ForgotScreenFormComponent(),


        ],
      ),
    );
  }
}
