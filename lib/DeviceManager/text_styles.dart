import 'package:flutter/material.dart';

import '../DeviceManager/screen_constants.dart';

class TextStyles {
  static TextStyle get blankTest => TextStyle(
        color: Colors.white70,
        fontSize: FontSize.s30,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get assetNameTextStyle => TextStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      );

  static TextStyle get symbolTextStyle => TextStyle(
        fontSize: FontSize.s14,
        fontWeight: FontWeight.w400,
        color: Colors.blue,
      );

  static TextStyle get priceLabelTextStyle => TextStyle(
        fontSize: FontSize.s17,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      );

  static TextStyle get marketCapTextStyle => TextStyle(
        fontSize: FontSize.s15,
        fontWeight: FontWeight.w500,
        color: Colors.grey.shade600,
      );

  static TextStyle get subTitle => TextStyle(
        color: Colors.black,
        fontSize: FontSize.s14,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get lowerSubTitle => TextStyle(
        color: Colors.black,
        fontSize: FontSize.s12,
        //fontWeight: FontWeight.w600,
      );
  static TextStyle get hintTextStyle => TextStyle(
        color: Colors.blueGrey.shade900,
        fontSize: FontSize.s16,
        //fontWeight: FontWeight.w600,
      );
  static TextStyle get titleFieldTextStyle => TextStyle(
        color: Colors.white,
        fontSize: FontSize.s18,
      );
  static TextStyle get loginButtonTextStyle => TextStyle(
        color: Colors.white,
        fontSize: FontSize.s22,
        fontWeight: FontWeight.w600,
      );
}
