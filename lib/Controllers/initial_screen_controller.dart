import 'dart:async';
import 'dart:convert';
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
  Rx<AllAssetsResponseModel> allAssetsResponseModel = AllAssetsResponseModel()
      .obs; //This is created to store the response from the API into the response model to use later.
  final StreamController<AllAssetsResponseModel> streamController =
      StreamController(); //Stream controller to stream the response from the API. We use streams since we need to update the app every second.

  late StreamSubscription
      connection; //Stream subscription to check the connection.
  RxBool isConnected = false.obs; //Rx bool to update the value of connection
  bool messageShown =
      false; //This is used later to show the connected/disconnected message only once.

//*This is the method to get the connection status and update the values accordingly.
  getConnectivity() => connection = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected.value = await InternetConnectionChecker().hasConnection;
        if (isConnected.value == true) {
          // log('Connected');
        } else {
          // log('Not connected');
          if (messageShown == false) {
            Get.snackbar(
              StringUtils.attention,
              StringUtils.connectionErrorMessage,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackStyle: SnackStyle.FLOATING,
              duration: const Duration(seconds: 3),
            );
          }
          messageShown = true;
        }
      });

  //*Init state calls the function to get the connection status and based on the connection status call the function to get the value of all assets.
  @override
  onInit() {
    getConnectivity();
    if (isConnected.value == false) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        getCryptoPrice();
      });
    } else {
      // log('message111111');
    }
    super.onInit();
  }

  @override
  dispose() {
    streamController.close();
    super.dispose();
  }
//!add a query param as "?limit=10" to get 10 assets can be used as a search function
//!add a query param as "?search=b" to get all assets starting with "B" can be used as a search function

//*Funtion to get the crypto prices, store it to a response model and stream it to the UI every second.

  Future<void> getCryptoPrice() async {
    var url = Uri.parse(baseUrl + getCoinList + "?API_KEY=$apiKey");
    // debugPrint(response.statusCode.toString());
    // debugPrint(url.toString());
    //*Setting file path to store the response in the cache.
    String fileName = "pathString.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected.value == false) {
      if (file.existsSync()) {
        // log('message');
        // log('Reading from cache');
        // log('message');
        final cacheData = file.readAsStringSync();
        final data = json.decode(cacheData);
        allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(data);
        streamController.sink.add(allAssetsResponseModel.value);
        // Get.snackbar('title', 'cache');
        return data;
      }
      //*If no internet exists, then read from the cache.

      //*If internet exists, fetch data from the API and store it in the cache and constantly update it.
    } else {
      // log('Reading from server');
      final response = await http.get(url);
      file.writeAsStringSync(response.body,
          flush: true,
          mode: FileMode.write); //*Writing the response to the cache.
      final data = json.decode(response.body);
      // log(response.statusCode.toString());
      // log(response.body);
      if (data == null) {
        if (Get.isDialogOpen ?? false) Get.back();
        return;
      } else {
        if (data['data'] != null) {
          if (Get.isDialogOpen ?? false) Get.back();
          allAssetsResponseModel.value = AllAssetsResponseModel.fromJson(
              data); //*Storing the response to the response model.
          streamController.sink.add(allAssetsResponseModel
              .value); //*Streaming the response to the UI.

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
