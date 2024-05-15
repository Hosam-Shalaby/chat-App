// ignore_for_file: unused_import, unused_local_variable, depend_on_referenced_packages


import 'package:chat/base/base.dart';
import 'package:chat/data%20base/my_data_base.dart';
import 'package:chat/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  var auth = FirebaseAuth.instance;
  void login(String email, String password) async {
    try {
      navigator?.showLoadingDialog();

      var credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator?.hideLoadingDialog;

      var retrievedUser = await MyDataBase.getUserById(credential.user!.uid);
      if (retrievedUser == null) {
        navigator?.showMessage('some thing went wrong');
      } else {
        SharedData.user = retrievedUser;
        navigator?.goToHome();
      }
      navigator?.hideLoadingDialog;

      navigator?.showMessage('Login Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator?.hideLoadingDialog();
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {}
    }
  }

  void checkLoggedInUser() async {
    if (auth.currentUser != null) {
      var retrievedUser = await MyDataBase.getUserById(auth.currentUser!.uid);
      SharedData.user = retrievedUser;
      navigator?.goToHome();
    }
  }
}
