import 'package:flutter/material.dart';

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
              color: Colors.blueGrey,
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
