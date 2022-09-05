import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  onSignInButtonTapped() {
    Get.toNamed(initalScreen);
  }
}
