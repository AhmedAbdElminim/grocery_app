import 'package:flutter/material.dart';
import 'package:grocery_app/features/auth/register/register_screen_form_component.dart';

import '../auth_background_component.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const  String registerScreenId='RegisterScreenId';
  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          AuthBackgroundComponent(),
          Container(height: screenHeight,width: screenWidth,color: Colors.black.withOpacity(.6),),
          SingleChildScrollView(child: RegisterScreenFormComponent())


        ],
      ),
    );
  }
}
