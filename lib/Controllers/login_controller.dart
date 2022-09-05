import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Widgets/show_toast.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FirebaseAuth firebaseInstance;

  @override
  onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firebaseInstance = FirebaseAuth.instance;
    debugData();
    super.onInit();
  }

  debugData() {
    if (kDebugMode) {
      emailController.text = 'sethia.rishabh007@gmail.com';
      passwordController.text = 'Password1';
    }
  }

  signInCheck() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {}
  }

  Future onSignInButtonTapped() async {
    // Get.isDialogOpen ?? true
    //     ? const Offstage()
    //     : Get.dialog(
    //         const Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //         barrierDismissible: false);
    try {
      await firebaseInstance.signInWithEmailAndPassword(
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
}
