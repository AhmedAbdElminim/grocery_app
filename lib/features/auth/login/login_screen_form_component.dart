import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/controllers/auth_controller/auth_cubit.dart';
import 'package:grocery_app/controllers/auth_controller/auth_states.dart';
import 'package:grocery_app/layout/layout.dart';
import 'package:grocery_app/shared/component/component.dart';
import 'package:grocery_app/shared/network/local.dart';

import '../frogot_password/forgot_password_screen.dart';
import '../register/register_screen.dart';

class LoginScreenFormComponent extends StatelessWidget {
  const LoginScreenFormComponent({Key? key}) : super(key: key);

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginUserSuccessStates) {
            Fluttertoast.showToast(
                msg: 'Login Done Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            navigateAndFinish(context, LayOut.layOutScreenId).then((value) {
              CacheHelper.saveData(key: 'token', value: true);
            });
          }
          if (state is LoginUserErrorStates) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);

          // emailController.text='test@test.com';
          // passController.text='123456';
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * .2,
                ),
                defaultText(
                    text: 'Welcome',
                    fontSize: 25,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
                defaultText(
                  text: 'Sign in to continue',
                  fontSize: 17,
                  fontColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: cubit.loginEmailController,
                          onChanged: (value) {
                            //  password=value;
                          },
                          style: const TextStyle(color: Colors.white),
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'Email must not be empty';
                            return null;
                          },
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: cubit.loginPassController,
                          onChanged: (value) {
                            // password=value;
                          },
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.visibility)),
                            fillColor: Colors.white,
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          navigateAndFinish(context,
                              ForgotPasswordScreen.forgotPasswordScreenId);
                        },
                        child: const Text('Forget Password?')),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                state is LoginUserLoadingStates
                    ? defaultLoading()
                    : InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loginUser(
                                email: cubit.loginEmailController.text,
                                password: cubit.loginPassController.text);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: defaultText(
                                  text: 'Sign In',
                                  fontSize: 20,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 2,
                      color: Colors.white,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: defaultText(
                          text: 'OR', fontSize: 20, fontColor: Colors.white),
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 2,
                      color: Colors.white,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: defaultText(
                          text: 'Continue as a guest',
                          fontSize: 17,
                          fontColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    defaultText(
                        text: 'Don\'t have an account?',
                        fontSize: 17,
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                              (route) => false);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 17),
                        )),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
