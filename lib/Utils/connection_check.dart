// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../Services/string_utils.dart';

class ConnectionCheck {
  late StreamSubscription connection;
  var isConnected = false;
  bool messageShown = false;
  RxString connectionVar = "".obs;

  getConnectivity() => connection = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;

        if (isConnected == true) {
          log('Connected value::::');
          log('Connected');
          connectionVar.value = 'Connected';
        } else {
          log('Connected value::::');

          log('Not connected');
          connectionVar.value = 'Not Connected';

          if (messageShown == false) {
            Get.snackbar(
              StringUtils.attention,
              StringUtils.connectionErrorMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              colorText: Colors.black,
              snackStyle: SnackStyle.FLOATING,
              duration: const Duration(seconds: 3),
            );
          }
          messageShown = true;
        }
      });
}
