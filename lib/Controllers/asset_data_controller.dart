import 'dart:async';
import 'dart:convert';

import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/ResponseModels/one_day_coint_history_response_model.dart';
import '../Services/string_utils.dart';
import '../Services/url.dart';

class AssetDataController extends GetxController {
  Rx<OneDayCoinHistoryResponseModel> oneDayCoinHistoryResponseModel =
      OneDayCoinHistoryResponseModel().obs;
  late StreamController<OneDayCoinHistoryResponseModel> streamController;

  String? assetHisoryUrl;
  List<ChartDataModel> chartDataModel = [];
  RxString interval = 'd1'.obs;

  //*To Get the coin history api.coincap.io/v2/assets/bitcoin/history?interval=d1

  @override
  onInit() {
    streamController = StreamController();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      chartDataModel.clear();
      getCoinHistory();
    });
    // getCoinHistory();
    super.onInit();
  }

  @override
  void dispose() {
    streamController.close(); // <== HERE !!!
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
    final response = await http.get(url);
    // debugPrint(response.statusCode.toString());
    debugPrint(url.toString());
    // debugPrint(response.body);

    final data = json.decode(response.body);
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
              int.tryParse(
                oneDayCoinHistoryResponseModel.value.data![i].time.toString(),
              )!,
            ),
          );
          // log(chartDataModel.first.year.toString());
          // closeStream();
          // oneDayCoinHistoryResponseModel.refresh();
        }
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar(StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);
      }
    }
  }

  Future<void> closeStream() {
    streamController.sink.close();
    return streamController.close();
  }
}
