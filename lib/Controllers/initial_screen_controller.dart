import 'dart:async';
import 'dart:developer';

import 'package:crypto_ticker/Models/ResponseModels/all_assets_response_model.dart';
import 'package:crypto_ticker/Services/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/core_services.dart';

class InitialScreenController extends GetxController {
  Rx<AllAssetsResponseModel> allAssetsResponseModel =
      AllAssetsResponseModel().obs;
  @override
  onInit() {
    Timer(const Duration(seconds: 0), () {
      Get.isDialogOpen ?? true
          ? const Offstage()
          : Get.dialog(const Center(child: CircularProgressIndicator()),
              barrierDismissible: false);
      getAssets();
    });
    super.onInit();
  }

  getAssets() async {
    debugPrint(baseUrl + getCoinList);
    var data = await CoreService().getWithoutAuth(url: baseUrl + getCoinList);
    if (data == null) {
      if (Get.isDialogOpen ?? false) Get.back();
      return;
    } else {
      if (data['data'] != null) {
        if (Get.isDialogOpen ?? false) Get.back();
        allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(data);
      }
    }
  }
}
