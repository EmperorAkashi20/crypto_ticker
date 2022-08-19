import 'package:crypto_ticker/Controllers/asset_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetDataView extends StatelessWidget {
  final AssetDataController assetDataController =
      Get.put(AssetDataController());
  AssetDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
