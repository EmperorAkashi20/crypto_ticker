import 'package:crypto_ticker/Services/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreService extends GetConnect {
  Future<dynamic> getWithoutAuth({required String url}) async {
    debugPrint("Url : $url");
    var data = await get(url);
    debugPrint("Body : ${data.body}");
    if (data.hasError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          StringUtils.error,
          data.body["message"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
      return null;
    } else if (data.status.hasError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          StringUtils.hasErrorTitle,
          StringUtils.hasErrorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
      return null;
    } else if (data.status.isServerError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          StringUtils.hasErrorTitle,
          StringUtils.hasErrorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });

      return null;
    } else if (data.status.connectionError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          StringUtils.hasErrorTitle,
          StringUtils.connectionErrorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
      return null;
    } else if (data.status.isNotFound) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.snackbar(
          StringUtils.hasErrorTitle,
          StringUtils.isNotFoundMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      });
      return null;
    } else {
      return data.body;
    }
  }
}
