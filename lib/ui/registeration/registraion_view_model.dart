// ignore_for_file: unused_import, unused_local_variable, depend_on_referenced_packages

import 'package:chat/base/base.dart';
import 'package:chat/data%20base/my_data_base.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegistrationNavigator extends BaseNavigator {
  void goToHome();
}

class RegistrationViewModel extends BaseViewModel<RegistrationNavigator> {
  void register(
      String email, String password, String fullName, String userName) async {
    try {
      navigator?.showLoadingDialog();

      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser newUser = MyUser(
        id: credential.user!.uid,
        email: email,
        userName: userName,
        fullName: fullName,
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      if (insertedUser != null) {
        // user inserted successfully
        SharedData.user = insertedUser;
        navigator?.goToHome();
        // go to next screen
      } else {
        //error with insert
        navigator?.showMessage('Error while registering');
      }
      navigator?.hideLoadingDialog;
      navigator?.showMessage('Registration Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideLoadingDialog();
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.hideLoadingDialog();
        navigator?.showMessage('The account already exists for that email.');
      }
    }
  }
}
