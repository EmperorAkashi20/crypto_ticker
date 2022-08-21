import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_ticker/Models/ResponseModels/all_assets_response_model.dart';
import 'package:crypto_ticker/Services/string_utils.dart';
import 'package:crypto_ticker/Services/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

class InitialScreenController extends GetxController {
  Rx<AllAssetsResponseModel> allAssetsResponseModel =
      AllAssetsResponseModel().obs;
  final StreamController<AllAssetsResponseModel> streamController =
      StreamController();
  late StreamSubscription connection;
  bool isConnected = false;
  bool messageShown = false;

  getConnectivity() => connection = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected = await InternetConnectionChecker().hasConnection;
        if (isConnected == true) {
          log('Connected');
        } else {
          log('Not connected');
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

  @override
  onInit() {
    getConnectivity();
    log(isConnected.toString());
    if (isConnected == false) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        getCryptoPrice();
      });
    } else {
      log('message111111');
    }
    super.onInit();
  }

  @override
  dispose() {
    streamController.close();
    connection.cancel();
    super.dispose();
  }
//!add a query param as "?limit=10" to get 10 assets
//!add a query param as "?search=b" to get all assets starting with "B"

  // getAssets() async {
  //   debugPrint(baseUrl + getCoinList);
  //   var data = await CoreService().getWithoutAuth(url: baseUrl + getCoinList);
  //   if (data == null) {
  //     if (Get.isDialogOpen ?? false) Get.back();
  //     return;
  //   } else {
  //     if (data['data'] != null) {
  //       if (Get.isDialogOpen ?? false) Get.back();
  //       allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(data);
  //     }
  //   }
  // }

  Future<void> getCryptoPrice() async {
    var url = Uri.parse(baseUrl + getCoinList + "?API_KEY=$apiKey");
    // debugPrint(response.statusCode.toString());
    // debugPrint(url.toString());
    String fileName = "pathString.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected == false) {
      debugPrint(file.existsSync().toString());
      if (file.existsSync()) {
        log('Reading from cache');
        final cacheData = file.readAsStringSync();
        final data = json.decode(cacheData);
        allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(data);
        streamController.sink.add(allAssetsResponseModel.value);
        // Get.snackbar('title', 'cache');
        return data;
      }
    } else {
      log('Reading from server');
      // Get.snackbar('title', 'server');

      final response = await http.get(url);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      final data = json.decode(response.body);
      if (data == null) {
        if (Get.isDialogOpen ?? false) Get.back();
        return;
      } else {
        if (data['data'] != null) {
          if (Get.isDialogOpen ?? false) Get.back();
          allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(data);
          streamController.sink.add(allAssetsResponseModel.value);

          return data;
        } else {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.snackbar(StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);
          return jsonDecode(response.body);
        }
      }
    }
  }
}
