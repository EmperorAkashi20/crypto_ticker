import 'dart:developer';

import 'package:crypto_ticker/Controllers/firebase_controller.dart';
import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:crypto_ticker/Utils/date_time_management.dart';
import 'package:crypto_ticker/Utils/firebase_collection_names.dart';
import 'package:crypto_ticker/Widgets/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final FirebaseController firebaseController = Get.find();

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  registerCheck() {
    if (nameController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      showToast('All fields are mandatory', 'attention');
    } else if (nameController.text.isEmpty) {
      showToast('Name is required', 'attention');
    } else if (emailController.text.isEmpty) {
      showToast('Email is required', 'attention');
    } else if (passwordController.text.isEmpty) {
      showToast('Password is required', 'attention');
    } else {
      onTapRegister();
    }
  }

  Future onTapRegister() async {
    try {
      await firebaseController.firebaseInstance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await firebaseController.firebaseFirestore
          .collection(collectionUser)
          .add({
            'email': emailController.text,
            'name': nameController.text,
            'dateOfCreation': DateTimeUtility().getToday(),
            'timeOfCreation': DateTimeUtility().getTimeNow(),
          })
          .then((value) => log('added'))
          .catchError((error) => log(error.toString()));
      Get.toNamed(loginScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('Weak Password', 'attention');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.', 'error');
      }
    } catch (e) {
      showToast(e.toString(), 'error');
      log(e.toString());
    }
  }

  onTapLogin() {
    Get.toNamed(loginScreen);
  }
}
