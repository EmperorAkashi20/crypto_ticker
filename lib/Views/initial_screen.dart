import 'package:crypto_ticker/Controllers/initial_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({Key? key}) : super(key: key);
  final InitialScreenController initialScreenController =
      Get.put(InitialScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          child: Center(
            child: Text(
              initialScreenController.allAssetsResponseModel.value.data![0].id
                  .toString(),
            ),
          ),
        ),
      ),
    );
  }
}
