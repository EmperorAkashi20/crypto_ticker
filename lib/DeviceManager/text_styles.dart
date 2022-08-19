import 'package:flutter/material.dart';

import '../DeviceManager/screen_constants.dart';

class TextStyles {
  static TextStyle get blankTest => TextStyle(
        color: Colors.white70,
        fontSize: FontSize.s30,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get assetNameTextStyle => TextStyle(
        fontSize: FontSize.s20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  static TextStyle get symbolTextStyle => TextStyle(
        fontSize: FontSize.s16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
}
