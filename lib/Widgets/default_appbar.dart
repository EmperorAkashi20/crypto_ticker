import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget {
  final double windowHeight;
  final double windowWidth;
  final Widget title;

  const DefaultAppBar({
    Key? key,
    required this.windowHeight,
    required this.windowWidth,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: title,
    );
  }
}
