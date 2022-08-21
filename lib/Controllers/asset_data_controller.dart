// ignore_for_file: prefer_typing_uninitialized_variables

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
          // log('Connected');
        } else {
          // log('Not connected');
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
    // log("Screen1");
    // log("connected value for screen 1");
    getConnectivity();

    if (isConnected.value == false) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        // log('init called');
        chartDataModel.clear();
        getCoinHistory();
        getAssetData();
      });
    } else {
      // log('message111111');
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
    String fileName = "pathString2.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected.value == true) {
      if (file.existsSync()) {
        // log('cache 2');
        log('Reading from cache');
        // log('cache 2');

        final cacheData = file.readAsStringSync();
        final data = json.decode(cacheData);
        // log('**********************');
        // log(data.toString());
        // log('**********************');
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
      }
    } else {
      // log('############################');
      // log('Reading from server');
      // log('############################');
      assetHisoryUrl = baseUrl +
          getCoinList +
          "/" +
          Get.arguments[0] +
          "/history?interval=${interval.value}&API_KEY=" +
          apiKey;
      var url = Uri.parse(assetHisoryUrl!);
      var response;
      var error;
      try {
        response = await http.get(url);
      } catch (e) {
        error = e.toString();
        log(e.toString());
      }
      if (error == "Failed host lookup: 'api.coincap.io'") {
        isConnected.value = !isConnected.value;
      }
      // debugPrint(response.statusCode.toString());
      // debugPrint(url.toString());
      // debugPrint(response.body);
      if (error != "Failed host lookup: 'api.coincap.io'") {
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
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
                      oneDayCoinHistoryResponseModel.value.data![i].time! *
                          1000),
                ),
              );
              // log(chartDataModel.first.year.toString());
              // closeStream();
              // oneDayCoinHistoryResponseModel.refresh();
            }
            return data;
          } else {
            if (Get.isDialogOpen ?? false) Get.back();
            Get.snackbar(
                StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);
            return jsonDecode(response.body);
          }
        }
      }
    }
  }

  Future<void> getAssetData() async {
    String fileName = "pathString1.json";
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + '/' + fileName);
    if (isConnected.value == false) {
      if (file.existsSync()) {
        // log('Reading from cache');
        final cacheData = file.readAsStringSync();
        final data = json.decode(cacheData);
        assetDataResponseModel.value = AssetDataResponseModel.fromJson(data);
        streamController1.sink.add(assetDataResponseModel.value);
        // Get.snackbar('title', 'cache');
        return data;
      }
    } else {
      // log('asset data Reading from server');
      assetDataUrl =
          baseUrl + getCoinList + "/" + Get.arguments[0] + "?API_KEY=$apiKey";
      var url = Uri.parse(assetDataUrl!);
      var response;
      var error;
      try {
        response = await http.get(url);
      } catch (e) {
        error = e.toString();
        log(e.toString());
      }
      if (error == "Failed host lookup: 'api.coincap.io'") {
        isConnected.value = !isConnected.value;
      }
      if (error != "Failed host lookup: 'api.coincap.io'") {
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        final data = json.decode(response.body);
        // debugPrint(response.statusCode.toString());
        // debugPrint(url.toString());
        if (data == null) {
          if (Get.isDialogOpen ?? false) Get.back();
          return;
        } else {
          if (data['data'] != null) {
            if (Get.isDialogOpen ?? false) Get.back();
            assetDataResponseModel.value =
                AssetDataResponseModel.fromJson(data);
            streamController1.sink.add(assetDataResponseModel.value);

            return data;
          } else {
            if (Get.isDialogOpen ?? false) Get.back();
            Get.snackbar(
                StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);

            return jsonDecode(response.body);
          }
        }
      }
    }
  }
}
