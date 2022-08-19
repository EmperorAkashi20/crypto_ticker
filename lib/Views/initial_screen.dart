import 'package:crypto_ticker/Controllers/initial_screen_controller.dart';
import 'package:crypto_ticker/DeviceManager/text_styles.dart';
import 'package:crypto_ticker/Models/ResponseModels/all_assets_response_model.dart';
import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DeviceManager/screen_constants.dart';

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

class AssetCard extends StatelessWidget {
  final double windowHeight;
  final double windowWidth;
  final String id;
  final String symbol;
  final String price;
  final String marketCap;
  final String rank;
  final String change24h;
  final IconData icon;
  final Color iconColor;

  const AssetCard({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.id,
    required this.symbol,
    required this.price,
    required this.marketCap,
    required this.rank,
    required this.change24h,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            assetDataHistory,
            arguments: [
              id,
              price,
              'https://assets.coincap.io/assets/icons/${symbol.toString().toLowerCase()}@2x.png',
            ],
          );
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: windowHeight * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          'https://assets.coincap.io/assets/icons/${symbol.toString().toLowerCase()}@2x.png',
                          // height: windowHeight * 0.1,
                          // width: windowWidth * 0.1,
                        ),
                      ),
                      SizedBox(
                        width: windowWidth * 0.03,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            id.length < 5
                                ? id.toUpperCase().replaceAll('Usd', 'USD')
                                : id
                                    .split('-')
                                    .join(' ')
                                    .capitalize!
                                    .replaceAll('Usd', 'USD'),
                            style: TextStyles.assetNameTextStyle,
                          ),
                          SizedBox(
                            height: windowHeight * 0.01,
                          ),
                          Row(
                            children: [
                              Container(
                                width: windowWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      rank,
                                      style: TextStyles.symbolTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: windowWidth * 0.01,
                              ),
                              Text(
                                symbol,
                                style: TextStyles.symbolTextStyle,
                              ),
                              SizedBox(
                                width: windowWidth * 0.01,
                              ),
                              Icon(
                                icon,
                                size: windowHeight * 0.03,
                                color: iconColor,
                              ),
                              Text(
                                change24h,
                                style: TextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w600,
                                  color: iconColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: windowWidth * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "US\$" +
                              price.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          style: TextStyles.priceLabelTextStyle,
                        ),
                        SizedBox(
                          height: windowHeight * 0.01,
                        ),
                        Text(
                          "mCap US\$" +
                              (double.tryParse(marketCap)! / 1000000000)
                                  .toStringAsFixed(2)
                                  .replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},') +
                              "Bn",
                          style: TextStyles.marketCapTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
