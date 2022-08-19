import 'package:crypto_ticker/Controllers/initial_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Obx(
        () => ListView.builder(
          itemCount: initialScreenController
                  .allAssetsResponseModel.value.data?.length ??
              0,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
              child: AssetCard(
                windowHeight: windowHeight,
                windowWidth: windowWidth,
                id: initialScreenController
                    .allAssetsResponseModel.value.data![index].id
                    .toString(),
                symbol: initialScreenController
                    .allAssetsResponseModel.value.data![index].symbol
                    .toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AssetCard extends StatelessWidget {
  final double windowHeight;
  final double windowWidth;
  final String id;
  final String symbol;

  const AssetCard({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.id,
    required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: windowHeight * 0.2,
        width: windowWidth * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(id),
            Text(symbol),
          ],
        ),
      ),
    );
  }
}
