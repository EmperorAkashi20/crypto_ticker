import 'package:crypto_ticker/Controllers/firebase_controller.dart';
import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/show_toast.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final FirebaseController firebaseController = Get.find();

  @override
  onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // debugData();
    super.onInit();
  }

  debugData() {
    if (kDebugMode) {
      emailController.text = 'sethia.rishabh007@gmail.com';
      passwordController.text = 'Password1';
    }
  }

  signInCheck() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      showToast('All fields are mandatory', 'attention');
    } else if (emailController.text.isEmpty) {
      showToast('Email required', 'attention');
    } else if (passwordController.text.isEmpty) {
      showToast('Password required', 'attention');
    } else {
      onSignInButtonTapped();
    }
  }

  Future onSignInButtonTapped() async {
    try {
      await firebaseController.firebaseInstance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          showToast('Please try again later', 'error');
        } else {
          Get.toNamed(initalScreen);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (Get.isDialogOpen ?? false) Get.back();
        showToast('User not registered', 'error');
      } else if (e.code == 'wrong-password') {
        if (Get.isDialogOpen ?? false) Get.back();
        showToast('Invalid Password', 'error');
      }
    }
  }

  onTapRegister() {
    Get.toNamed(registrationScreen);
  }
}
