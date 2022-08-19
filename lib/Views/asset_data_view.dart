import 'dart:developer';

import 'package:crypto_ticker/Controllers/asset_data_controller.dart';
import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetDataView extends StatelessWidget {
  final AssetDataController assetDataController =
      Get.put(AssetDataController());
  AssetDataView({Key? key}) : super(key: key);
//Graph for coin history
  @override
  Widget build(BuildContext context) {
    log(assetDataController.chartDataModel.first.year.toString());
    return Scaffold(
      body: Center(
        child: Container(
          height: Get.height * 0.5,
          width: double.infinity,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(),
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
            ),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<ChartDataModel, dynamic>>[
              SplineSeries<ChartDataModel, dynamic>(
                dataSource: assetDataController.chartDataModel,
                xValueMapper: (ChartDataModel chartDataModel, _) =>
                    chartDataModel.year,
                yValueMapper: (ChartDataModel chartDataModel, _) =>
                    chartDataModel.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
