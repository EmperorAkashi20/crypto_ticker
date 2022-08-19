import 'package:crypto_ticker/Controllers/initial_screen_controller.dart';
import 'package:crypto_ticker/DeviceManager/screen_constants.dart';
import 'package:crypto_ticker/DeviceManager/text_styles.dart';
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
        height: windowHeight * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                'https://assets.coincap.io/assets/icons/${symbol.toString().toLowerCase()}@2x.png',
                height: windowHeight * 0.1,
                width: windowWidth * 0.1,
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
                        ? id.toUpperCase()
                        : id.split('-').join(' ').capitalize!,
                    style: TextStyles.assetNameTextStyle,
                  ),
                  Text(
                    symbol,
                    style: TextStyles.symbolTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
