import 'package:crypto_ticker/DeviceManager/screen_constants.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final double windowHeight;
  final double windowWidth;
  final Widget title;
  final List<Widget>? actions;

  const DefaultAppBar(
      {Key? key,
      required this.windowHeight,
      required this.windowWidth,
      required this.title,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
        height: windowHeight * 0.3,
        decoration: BoxDecoration(
          // color: Colors.blueGrey.shade700,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey.shade800,
              Colors.blueGrey.shade900,
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
          ),
        ),
      ),
      title: title,
      titleTextStyle: TextStyle(
        fontSize: FontSize.s22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
