import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_ticker/Models/ResponseModels/asset_data_response_model.dart';
import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/ResponseModels/one_day_coint_history_response_model.dart';
import '../Services/string_utils.dart';
import '../Services/url.dart';

class AssetDataController extends GetxController {
  Rx<OneDayCoinHistoryResponseModel> oneDayCoinHistoryResponseModel =
      OneDayCoinHistoryResponseModel().obs;
  final StreamController<OneDayCoinHistoryResponseModel> streamController =
      StreamController();

  Rx<AssetDataResponseModel> assetDataResponseModel =
      AssetDataResponseModel().obs;
  final StreamController<AssetDataResponseModel> streamController1 =
      StreamController();

  late StreamSubscription connection;
  RxBool isConnected = false.obs;
  bool messageShown = false;

  getConnectivity() => connection = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isConnected.value = await InternetConnectionChecker().hasConnection;
        if (isConnected.value == true) {
          log('Connected');
        } else {
          log('Not connected');
          messageShown = true;
        }
      });

  String? assetHisoryUrl;
  String? assetDataUrl;
  List<ChartDataModel> chartDataModel = [];
  RxString interval = 'd1'.obs;

  //*To Get the coin history api.coincap.io/v2/assets/bitcoin/history?interval=d1

  @override
  onInit() {
    log("Screen1");
    log("connected value for screen 1");
    getConnectivity();
    assetDataUrl =
        baseUrl + getCoinList + "/" + Get.arguments[0] + "?API_KEY=$apiKey";
    if (isConnected.value == false) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        log('init called');
        chartDataModel.clear();
        getCoinHistory();
        getAssetData();
      });
    } else {
      log('message111111');
    }
    super.onInit();
  }

  @override
  void dispose() {
    streamController.close();
    streamController1.close();
    super.dispose();
  }

  Future<void> getCoinHistory() async {
    assetHisoryUrl = baseUrl +
        getCoinList +
        "/" +
        Get.arguments[0] +
        "/history?interval=${interval.value}&API_KEY=" +
        apiKey;
    var url = Uri.parse(assetHisoryUrl!);
    String fileName = "pathString.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected.value == true) {
      // if (file.existsSync()) {
      //   log('cache 2');
      //   log('Reading from cache');
      //   log('cache 2');

      //   final cacheData = file.readAsStringSync();
      //   final data = json.decode(cacheData);
      //   log('**********************');
      //   // log(data.toString());
      //   // log('**********************');
      //   oneDayCoinHistoryResponseModel.value =
      //       OneDayCoinHistoryResponseModel.fromJson(data);
      //   streamController.sink.add(oneDayCoinHistoryResponseModel.value);
      //   for (int i = 0;
      //       i < oneDayCoinHistoryResponseModel.value.data!.length;
      //       i++) {
      //     chartDataModel.add(
      //       ChartDataModel(
      //         double.tryParse(
      //             oneDayCoinHistoryResponseModel.value.data![i].priceUsd!)!,
      //         DateTime.fromMicrosecondsSinceEpoch(
      //             oneDayCoinHistoryResponseModel.value.data![i].time! * 1000),
      //       ),
      //     );
      //     // log(chartDataModel.first.year.toString());
      //     // closeStream();
      //     // oneDayCoinHistoryResponseModel.refresh();
      //   }
      //   // Get.snackbar('title', 'cache');
      // }
      // Get.snackbar(
      //   StringUtils.error,
      //   StringUtils.connectionErrorMessage,
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackStyle: SnackStyle.FLOATING,
      //   duration: const Duration(seconds: 3),
      // );
    } else {
      log('############################');
      log('Reading from server');
      log('############################');

      final response = await http.get(url);
      // debugPrint(response.statusCode.toString());
      // debugPrint(url.toString());
      // debugPrint(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      final data = json.decode(response.body);
      // log(data.toString());
      if (data == null) {
        if (Get.isDialogOpen ?? false) Get.back();
        return;
      } else {
        if (data['data'] != null) {
          if (Get.isDialogOpen ?? false) Get.back();
          oneDayCoinHistoryResponseModel.value =
              OneDayCoinHistoryResponseModel.fromJson(data);
          streamController.sink.add(oneDayCoinHistoryResponseModel.value);
          for (int i = 0;
              i < oneDayCoinHistoryResponseModel.value.data!.length;
              i++) {
            chartDataModel.add(
              ChartDataModel(
                double.tryParse(
                    oneDayCoinHistoryResponseModel.value.data![i].priceUsd!)!,
                DateTime.fromMicrosecondsSinceEpoch(
                    oneDayCoinHistoryResponseModel.value.data![i].time! * 1000),
              ),
            );
            // log(chartDataModel.first.year.toString());
            // closeStream();
            // oneDayCoinHistoryResponseModel.refresh();
          }
          return data;
        } else {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.snackbar(StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);
          return jsonDecode(response.body);
        }
      }
    }
  }

  Future<void> getAssetData() async {
    var url = Uri.parse(assetDataUrl!);
    String fileName = "pathString1.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected.value == true) {
      // if (file.existsSync()) {
      //   log('Reading from cache');
      //   final cacheData = file.readAsStringSync();
      //   final data = json.decode(cacheData);
      //   assetDataResponseModel.value = AssetDataResponseModel.fromJson(data);
      //   streamController1.sink.add(assetDataResponseModel.value);
      //   // Get.snackbar('title', 'cache');
      //   return data;
      // }
      // Get.snackbar(
      //   StringUtils.error,
      //   StringUtils.connectionErrorMessage,
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackStyle: SnackStyle.FLOATING,
      //   duration: const Duration(seconds: 3),
      // );
    } else {
      log('asset data Reading from server');
      final response = await http.get(url);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      final data = json.decode(response.body);
      // debugPrint(response.statusCode.toString());
      // debugPrint(url.toString());
      if (data == null) {
        if (Get.isDialogOpen ?? false) Get.back();
        return;
      } else {
        if (data['data'] != null) {
          if (Get.isDialogOpen ?? false) Get.back();
          assetDataResponseModel.value = AssetDataResponseModel.fromJson(data);
          streamController1.sink.add(assetDataResponseModel.value);

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
