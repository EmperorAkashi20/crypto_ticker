import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/ResponseModels/one_day_coint_history_response_model.dart';
import '../Services/string_utils.dart';
import '../Services/url.dart';

class AssetDataController extends GetxController {
  Rx<OneDayCoinHistoryResponseModel> oneDayCoinHistoryResponseModel =
      OneDayCoinHistoryResponseModel().obs;
  final StreamController<OneDayCoinHistoryResponseModel> streamController =
      StreamController();
  //!To Get the coin history api.coincap.io/v2/assets/bitcoin/history?interval=d1

  @override
  onInit() {
    debugPrint(baseUrl + "assets/" + Get.arguments[0] + "/history?interval=d1");
    super.onInit();
  }

  Future<void> getCointHistory() async {
    var url = Uri.parse(baseUrl + getCoinList + "?API_KEY=$apiKey");
    final response = await http.get(url);
    // debugPrint(response.statusCode.toString());
    debugPrint(url.toString());

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
      } else {
        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar(StringUtils.hasErrorMessage, StringUtils.hasErrorTitle);
      }
    }
  }
}
