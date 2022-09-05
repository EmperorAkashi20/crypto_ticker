import 'package:crypto_ticker/Controllers/login_controller.dart';
import 'package:crypto_ticker/DeviceManager/screen_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/primary_button.dart';
import '../Widgets/text_fields.dart';
import '../Widgets/text_form_field_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    double windowHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey.shade900,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: windowHeight * 0.15,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: FontSize.s36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.01,
                ),
                Text(
                  "Please login to continue",
                  style: TextStyle(
                    fontSize: FontSize.s18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: windowHeight * 0.08,
                ),
                const TextFormFieldTitle(
                  title: "Email",
                ),
                SizedBox(
                  height: windowHeight * 0.01,
                ),
                TextFields(
                  textEditingController: loginController.emailController,
                  type: Type.email,
                ),
                SizedBox(
                  height: windowHeight * 0.03,
                ),
                const TextFormFieldTitle(
                  title: "Password",
                ),
                SizedBox(
                  height: windowHeight * 0.01,
                ),
                TextFields(
                  textEditingController: loginController.passwordController,
                  type: Type.password,
                ),
                SizedBox(
                  height: windowHeight * 0.05,
                ),
                PrimaryButton(
                  windowHeight: windowHeight,
                  text: 'Login',
                  onTap: () {
                    loginController.signInCheck();
                  },
                ),
                SizedBox(
                  height: windowHeight * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Register here',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
