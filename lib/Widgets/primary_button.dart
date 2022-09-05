import 'package:flutter/material.dart';

import '../DeviceManager/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final double windowHeight;
  final String text;
  final Function onTap;

  const PrimaryButton(
      {Key? key,
      required this.windowHeight,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        child: Container(
          height: windowHeight * 0.065,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blueGrey.shade600,
                Colors.blueGrey.shade700,
              ],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyles.loginButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
