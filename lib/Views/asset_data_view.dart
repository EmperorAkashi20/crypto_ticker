import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_ticker/Controllers/asset_data_controller.dart';
import 'package:crypto_ticker/DeviceManager/screen_constants.dart';
import 'package:crypto_ticker/Models/ResponseModels/asset_data_response_model.dart';
import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Models/ResponseModels/one_day_coint_history_response_model.dart';
import '../Widgets/asset_data_row.dart';
import '../Widgets/default_appbar.dart';
import '../Widgets/interval_container.dart';

class AssetDataView extends StatelessWidget {
  final AssetDataController assetDataController =
      Get.put(AssetDataController());
  // final InitialScreenController initialScreenController = Get.find();
  AssetDataView({Key? key}) : super(key: key);
//Graph for coin history
  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(windowHeight * 0.08),
        child: DefaultAppBar(
          windowHeight: windowHeight,
          windowWidth: windowWidth,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: Get.arguments[2],
                height: windowHeight * 0.055,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(
                width: windowWidth * 0.02,
              ),
              Text(
                Get.arguments[0].toString().length < 5
                    ? Get.arguments[0]
                        .toString()
                        .toUpperCase()
                        .replaceAll('Usd', 'USD')
                    : Get.arguments[0]
                        .split('-')
                        .join(' ')
                        .toString()
                        .capitalize!
                        .replaceAll('Usd', 'USD'),
              ),
              Text(" (${Get.arguments[3]})")
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: windowHeight * 0.03,
          ),
          Container(
            height: Get.height * 0.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: StreamBuilder<OneDayCoinHistoryResponseModel>(
              stream: assetDataController.streamController.stream,
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
                      return SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: DateTimeAxis(
                          axisLine: const AxisLine(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          isVisible: true,
                          majorGridLines: const MajorGridLines(width: 0),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.009,
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(
                            color: Colors.transparent,
                            width: 2,
                          ),
                          numberFormat: NumberFormat.simpleCurrency(),
                          isVisible: true,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.009,
                          ),
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: false),
                        series: <ChartSeries<ChartDataModel, dynamic>>[
                          SplineSeries<ChartDataModel, dynamic>(
                            animationDuration: 500,
                            dataSource: assetDataController.chartDataModel,
                            xValueMapper: (ChartDataModel chartDataModel, _) =>
                                chartDataModel.date,
                            yValueMapper: (ChartDataModel chartDataModel, _) =>
                                chartDataModel.value,
                          ),
                        ],
                      );
                    }
                }
              },
            ),
          ),
          SizedBox(
            height: windowHeight * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntervalContainer(
                  windowHeight: windowHeight,
                  windowWidth: windowWidth,
                  interval: "D1",
                  button: TextButton(
                    onPressed: () {
                      assetDataController.interval.value = 'd1';
                    },
                    child: const Text('D1'),
                  ),
                ),
                IntervalContainer(
                  windowHeight: windowHeight,
                  windowWidth: windowWidth,
                  interval: "M5",
                  button: TextButton(
                    onPressed: () {
                      assetDataController.interval.value = 'm5';
                    },
                    child: const Text('M5'),
                  ),
                ),
                IntervalContainer(
                  windowHeight: windowHeight,
                  windowWidth: windowWidth,
                  interval: "M15",
                  button: TextButton(
                    onPressed: () {
                      assetDataController.interval.value = 'm15';
                    },
                    child: const Text('M15'),
                  ),
                ),
                IntervalContainer(
                  windowHeight: windowHeight,
                  windowWidth: windowWidth,
                  interval: "M30",
                  button: TextButton(
                    onPressed: () {
                      assetDataController.interval.value = 'm30';
                    },
                    child: const Text('M30'),
                  ),
                ),
                IntervalContainer(
                  windowHeight: windowHeight,
                  windowWidth: windowWidth,
                  interval: "H12",
                  button: TextButton(
                    onPressed: () {
                      assetDataController.interval.value = 'h12';
                    },
                    child: const Text('H12'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: windowHeight * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              child: StreamBuilder<AssetDataResponseModel>(
                stream: assetDataController.streamController1.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: Text("Loading...."),
                      );
                    default:
                      if (snapshot.hasError) {
                        return const Text("Please Wait....");
                      } else {
                        return Column(
                          children: [
                            DataRowForAssets(
                              dataLabel: "Rank",
                              value: assetDataController
                                  .assetDataResponseModel.value.data!.rank
                                  .toString()
                                  .capitalize!,
                            ),
                            DataRowForAssets(
                              dataLabel: "Id",
                              value: assetDataController
                                  .assetDataResponseModel.value.data!.id
                                  .toString()
                                  .capitalize!,
                            ),
                            DataRowForAssets(
                              dataLabel: "Symbol",
                              value: assetDataController
                                  .assetDataResponseModel.value.data!.symbol
                                  .toString(),
                            ),
                            DataRowForAssets(
                              dataLabel: "Name",
                              value: assetDataController
                                  .assetDataResponseModel.value.data!.name
                                  .toString()
                                  .capitalize!
                                  .replaceAll('Usd', 'USD'),
                            ),
                            DataRowForAssets(
                              dataLabel: "Supply",
                              value: (double.tryParse(
                                            assetDataController
                                                .assetDataResponseModel
                                                .value
                                                .data!
                                                .supply
                                                .toString(),
                                          )! /
                                          1000000)
                                      .toStringAsFixed(2) +
                                  'm ${assetDataController.assetDataResponseModel.value.data!.symbol.toString()}',
                            ),
                            // DataRowForAssets(
                            //   dataLabel: "Max Supply",
                            //   value: (double.tryParse(
                            //                 assetDataController
                            //                     .assetDataResponseModel
                            //                     .value
                            //                     .data!
                            //                     .maxSupply
                            //                     .toString(),
                            //               )! /
                            //               1000000)
                            //           .toStringAsFixed(2) +
                            //       'm ${assetDataController.assetDataResponseModel.value.data!.symbol.toString()}',
                            // ),
                            DataRowForAssets(
                              dataLabel: "Market Cap",
                              value: "\$" +
                                  (double.tryParse(
                                            assetDataController
                                                .assetDataResponseModel
                                                .value
                                                .data!
                                                .marketCapUsd
                                                .toString(),
                                          )! /
                                          1000000000)
                                      .toStringAsFixed(2) +
                                  'Bn',
                            ),
                            DataRowForAssets(
                              dataLabel: "Volume (24h)",
                              value: "\$" +
                                  (double.tryParse(
                                            assetDataController
                                                .assetDataResponseModel
                                                .value
                                                .data!
                                                .volumeUsd24Hr
                                                .toString(),
                                          )! /
                                          1000000000)
                                      .toStringAsFixed(2) +
                                  'Bn',
                            ),
                            DataRowForAssets(
                              dataLabel: "Price USD",
                              value: "\$" +
                                  (double.tryParse(
                                    assetDataController.assetDataResponseModel
                                        .value.data!.priceUsd
                                        .toString(),
                                  )!
                                      .toStringAsFixed(2)
                                      .replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},')),
                            ),
                            DataRowForAssets(
                              dataLabel: "Change% (24h)",
                              value: "\$" +
                                  (double.tryParse(
                                    assetDataController.assetDataResponseModel
                                        .value.data!.changePercent24Hr
                                        .toString(),
                                  )!
                                      .toStringAsFixed(2)),
                            ),
                          ],
                        );
                      }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
