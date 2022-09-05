import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FirebaseAuth firebaseInstance;

  @override
  onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firebaseInstance = FirebaseAuth.instance;
    super.onInit();
  }

  Future onSignInButtonTapped() async {
    Get.isDialogOpen ?? true
        ? const Offstage()
        : Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false);
    try {
      await firebaseInstance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Fluttertoast.showToast(
            timeInSecForIosWeb: 3,
            msg: "Some error occured, Please try again later",
            backgroundColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            fontSize: 20.0,
          );
        } else {
          Get.toNamed(initalScreen);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (Get.isDialogOpen ?? false) Get.back();
        Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: "User not registered",
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          fontSize: 20.0,
        );
      } else if (e.code == 'wrong-password') {
        if (Get.isDialogOpen ?? false) Get.back();
        Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: "Incorrect Password",
          backgroundColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          fontSize: 20.0,
        );
      }
    }
  }
}
