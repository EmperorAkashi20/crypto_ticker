import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DeviceManager/screen_constants.dart';
import '../DeviceManager/text_styles.dart';
import '../Router/route_constants.dart';

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
              symbol,
            ],
          );
        },
        child: Card(
          color: Colors.blueGrey.shade900,
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
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Card(
                        color: Colors.transparent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: windowHeight * 0.055,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://assets.coincap.io/assets/icons/${symbol.toString().toLowerCase()}@2x.png',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            // height: windowHeight * 0.1,
                            // width: windowWidth * 0.1,
                          ),
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
