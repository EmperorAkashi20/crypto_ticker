import 'package:flutter/material.dart';

import '../DeviceManager/screen_constants.dart';

class DataRowForAssets extends StatelessWidget {
  final String dataLabel;
  final String value;
  const DataRowForAssets({
    required this.dataLabel,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dataLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: FontSize.s18,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade600,
                fontSize: FontSize.s18,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 0.5,
        ),
      ],
    );
  }
}
