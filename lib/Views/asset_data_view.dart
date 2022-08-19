import 'package:crypto_ticker/Controllers/asset_data_controller.dart';
import 'package:crypto_ticker/Models/chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetDataView extends StatelessWidget {
  final AssetDataController assetDataController =
      Get.put(AssetDataController());
  AssetDataView({Key? key}) : super(key: key);
//Graph for coin history
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => Container(
          padding: const EdgeInsets.only(left: 16.0),
          height: 96.0,
          width: double.infinity,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(isVisible: false),
            primaryYAxis: CategoryAxis(isVisible: false),
            legend: Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<ChartDataModel, String>>[
              LineSeries<ChartDataModel, String>(
                enableTooltip: false,
                isVisibleInLegend: false,
                dataSource: assetDataController.chartDataModel,
                xValueMapper: (ChartDataModel sales, _) =>
                    sales.year.toString(),
                yValueMapper: (ChartDataModel sales, _) => sales.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
