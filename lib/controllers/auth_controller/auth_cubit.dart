import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/shared/consts/constants.dart';
import 'package:grocery_app/shared/network/local.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialStates());
  static AuthCubit get(context) => BlocProvider.of(context);
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPassController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerAddressController =
      TextEditingController();
  Future<void> registerNewUser(
      {required String email,
      required String password,
      required String name,
      required String shippingAddress}) async {
    try {
      emit(RegisterNewUserLoadingStates());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        createNewUser(
          uId: value.user!.uid,
          name: name,
          email: email,
          shippingAddress: shippingAddress,
        );
        token=value.user!.uid;
        CacheHelper.saveData(key: 'token', value: value.user!.uid);
        getUserData(uId: value.user!.uid);
        emit(RegisterNewUserSuccessStates());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterNewUserErrorStates('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterNewUserErrorStates(
            'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterNewUserErrorStates(e.toString()));
    }
  }

  void createNewUser(
      {required String uId,
      required String name,
      required String email,
      required String shippingAddress}) async {
    try {
      UserModel userModel = UserModel(
          uId: uId, name: name, email: email, shippingAddress: shippingAddress);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(userModel.toJson())
          .then((value) {});
    } catch (error) {
      emit(CreateNewUserErrorStates(error.toString()));
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      emit(LoginUserLoadingStates());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            token=value.user!.uid;
        CacheHelper.saveData(key: 'token', value: value.user!.uid);
        getUserData(uId: value.user!.uid);
        emit(LoginUserSuccessStates());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        emit(LoginUserErrorStates('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginUserErrorStates('Wrong password provided for that user.'));
      }
    }
  }

  Future<void> getUserData({required String uId}) async {
  //  print('I\'m reach to here');
    try {
       //emit(GetUserDataLoadingStates());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);


         // emit(GetUserDataSuccessStates());
      });
    } catch (error) {
    //  print('the error is  here');
      // emit(GetUserDataErrorStates(error.toString()));
    }
  }

}
