import 'package:crypto_ticker/Controllers/asset_data_controller.dart';
import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Controllers/initial_screen_controller.dart';
import '../Models/ResponseModels/one_day_coint_history_response_model.dart';

class AssetDataView extends StatelessWidget {
  final AssetDataController assetDataController =
      Get.put(AssetDataController());
  final InitialScreenController initialScreenController = Get.find();
  AssetDataView({Key? key}) : super(key: key);
//Graph for coin history
  @override
  Widget build(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    double windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(windowHeight * 0.08),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: Container(
            height: windowHeight * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Get.arguments[2],
                height: windowHeight * 0.055,
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
            ],
          ),
        ),
      ),
      body: Column(
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
        ],
      ),
    );
  }
}

class IntervalContainer extends StatelessWidget {
  final double windowHeight;
  final double windowWidth;
  final String interval;
  final Widget button;

  const IntervalContainer({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.interval,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: windowHeight * 0.06,
          width: windowWidth * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: button,
          ),
        ),
      ),
    );
  }
}
