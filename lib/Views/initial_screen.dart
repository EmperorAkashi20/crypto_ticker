import 'package:crypto_ticker/Controllers/initial_screen_controller.dart';
import 'package:crypto_ticker/DeviceManager/text_styles.dart';
import 'package:crypto_ticker/Models/ResponseModels/all_assets_response_model.dart';
import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:crypto_ticker/Widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DeviceManager/screen_constants.dart';
import '../Widgets/asset_card.dart';

class InitialScreen extends StatelessWidget {
  InitialScreen({Key? key}) : super(key: key);
  final InitialScreenController initialScreenController =
      Get.put(InitialScreenController());

  @override
  Widget build(BuildContext context) {
    debugPrint(initialScreenController.allAssetsResponseModel.value.data?.length
        .toString());
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(windowHeight * 0.08),
        child: DefaultAppBar(
          windowHeight: windowHeight,
          windowWidth: windowWidth,
          title: const Text('Crypto Ticker'),
        ),
      ),
      body: StreamBuilder<AllAssetsResponseModel>(
        stream: initialScreenController.streamController.stream,
        builder: (context, snapdata) {
          switch (snapdata.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapdata.hasError) {
                return const Text('Please Wait....');
              } else {
                return ListView.builder(
                  itemCount: initialScreenController
                          .allAssetsResponseModel.value.data?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2),
                      child: AssetCard(
                        windowHeight: windowHeight,
                        windowWidth: windowWidth,
                        id: initialScreenController
                            .allAssetsResponseModel.value.data![index].id
                            .toString(),
                        symbol: initialScreenController
                            .allAssetsResponseModel.value.data![index].symbol
                            .toString(),
                        rank: initialScreenController
                            .allAssetsResponseModel.value.data![index].rank
                            .toString(),
                        change24h: double.tryParse(initialScreenController
                                    .allAssetsResponseModel
                                    .value
                                    .data![index]
                                    .changePercent24Hr!)!
                                .toStringAsFixed(2)
                                .replaceAll('-', '') +
                            "%",
                        icon: initialScreenController.allAssetsResponseModel
                                .value.data![index].changePercent24Hr!
                                .toString()
                                .contains('-')
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        iconColor: initialScreenController
                                .allAssetsResponseModel
                                .value
                                .data![index]
                                .changePercent24Hr!
                                .toString()
                                .contains('-')
                            ? Colors.red
                            : Colors.green,
                        price: double.tryParse(initialScreenController
                                .allAssetsResponseModel
                                .value
                                .data![index]
                                .priceUsd!)!
                            .toStringAsFixed(2),
                        marketCap: initialScreenController
                            .allAssetsResponseModel
                            .value
                            .data![index]
                            .marketCapUsd
                            .toString(),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
