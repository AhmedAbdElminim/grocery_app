import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:grocery_app/controllers/auth_controller/auth_cubit.dart';
import 'package:grocery_app/features/auth/login/login_screen.dart';
import 'package:grocery_app/layout/layout.dart';
import 'package:grocery_app/shared/component/component.dart';

import '../../../controllers/auth_controller/auth_states.dart';

class RegisterScreenFormComponent extends StatelessWidget {
  const RegisterScreenFormComponent({Key? key}) : super(key: key);

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterNewUserSuccessStates) {
            Fluttertoast.showToast(
                msg: 'Register Done Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            navigateAndFinish(context, LayOut.layOutScreenId);
          }
          if (state is RegisterNewUserErrorStates) {
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
                    text: 'Sign up to continue',
                    fontSize: 17,
                    fontColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: cubit.registerNameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Name must not be empty';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: cubit.registerEmailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      visiblePassFun: () {},
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Email must not be empty';
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: cubit.registerPassController,
                      hintText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      visiblePassFun: () {},
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Password must not be empty';
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                      controller: cubit.registerAddressController,
                      hintText: 'Shipping Address',
                      keyboardType: TextInputType.text,
                      visiblePassFun: () {},
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Address must not be empty';
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  state is RegisterNewUserLoadingStates
                      ? defaultLoading()
                      : InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.registerNewUser(
                                  email: cubit.registerEmailController.text,
                                  password: cubit.registerPassController.text,
                                  name: cubit.registerNameController.text,
                                  shippingAddress:
                                      cubit.registerAddressController.text);
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
                                    text: 'Sign Up',
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
                  Row(
                    children: [
                      defaultText(
                          text: 'Already have an account?',
                          fontSize: 17,
                          fontColor: Colors.white,
                          fontWeight: FontWeight.bold),
                      TextButton(
                          onPressed: () {
                            navigateAndFinish(
                                context, LoginScreen.loginScreenId);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
