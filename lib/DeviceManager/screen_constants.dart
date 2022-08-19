import 'device_manager.dart';
import 'package:flutter/material.dart';

Size screenSize = const Size(0, 0);
double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class ScreenConstant {
  /*Nimmio Default height */
  static double defaultHeightNinetyEight = 98;
  static double defaultHeightEightyTwo = 82;
  static double defaultHeightSeventySix = 76;
  static double defaultHeightNinety = 90;
  static double defaultHeightForty = 40;
  static double defaultHeightFifteen = 15;
  static double defaultHeightTwentyThree = 23;
  static double defaultHeightSixty = 60;
  static double defaultHeightTen = 10;
  static double defaultHeightSeventy = 70;
  static double defaultHeightOneThirty = 130;
  static double defaultHeightOneForty = 140;
  static double defaultHeightOneFifty = 150.0;
  static double defaultHeightOneEighty = 180.0;
  static double defaultHeightOneHundred = 100;
  static double defaultHeightTwoHundred = 200;
  static double defaultHeightTwoHundredThirty = 230;
  static double defaultHeightTwoHundredFifty = 350;

  /*Nimmio Default width */
  static double defaultWidthNinetyEight = 98;
  static double defaultWidthOneEighty = 180;
  static double defaultWidthOneSeventy = 170;
  static double defaultWidthThreeThirtySix = 336;
  static double defaultWidthOneHundredSeven = 107;
  static double defaultWidthSixty = 60;
  static double defaultWidthTen = 10;
  static double defaultWidthTwenty = 20;
  static double defaultWidthOneNinety = 210;

  /*Padding & Margin Constants*/
  static double sizeExtraSmall = 5.0;
  static double sizeDefault = 8.0;
  static double sizeSmall = 10.0;
  static double sizeMedium = 15.0;
  static double sizeLarge = 20.0;
  static double sizeMidLarge = 25.0;
  static double sizeExtraLarge = 30.0;
  static double sizeHighest = 160.0;
  static double sizeXL = 30.0;
  static double sizeXXL = 40.0;
  static double sizeXXXL = 50.0;
  static double sizeUltraXXXL = 65.0;

  /*Screen Size dependent Constants*/
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;
  static double screenWidthEleven = screenWidth / 11;
  static double screenWidthTwelve = screenWidth / 12;
  static double screenWidthThirteen = screenWidth / 13;
  static double screenWidthFourteen = screenWidth / 14;
  static double screenWidthFifteen = screenWidth / 15;
  static double screenWidthMinimum = screenWidth / 25;

  /*Screen Size dependent Constants*/
  static double screenHeightHalf = screenHeight / 2;
  static double screenHeightThird = screenHeight / 3;
  static double screenHeightFourth = screenHeight / 4;
  static double screenHeightFifth = screenHeight / 5;
  static double screenHeightSixth = screenHeight / 6;
  static double screenHeightTenth = screenHeight / 10;
  static double screenHeightEleven = screenHeight / 11;
  static double screenHeightTwelve = screenHeight / 12;
  static double screenHeightThirteen = screenHeight / 13;
  static double screenHeightFourteen = screenHeight / 14;
  static double screenHeightFifteen = screenHeight / 15;
  static double screenHeightMinimum = screenHeight / 25;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double miniIconSize = 66.0;
  static double defaultImageHeight = 120.0;
  static double defaultDialogHeight = 450.0;
  static double defaultMidHeight = 350.0;
  static double defaultImageWidth = screenWidth;
  static double defaultImageWidthThird = screenWidth / 3;
  static double defaultImageWidthFourth = screenWidth / 4;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;

  /*Default Height&Width*/
  static double defaultHelpBoxHeight = 226.8;
  static double defaultSizeTwoFifty = 250;
  static double defaultSizeThreeTwenty = 320;
  static double defaultSizeFourFifty = 450;
  static double defaultSizeOneTwenty = 120;
  static double defaultSizeOneTen = 110;
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets spacingAllZero = const EdgeInsets.all(0);
  static EdgeInsets spacingAllDefault = EdgeInsets.all(sizeDefault);
  static EdgeInsets spacingAllExtraSmall = EdgeInsets.all(sizeExtraSmall);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(sizeSmall);
  static EdgeInsets spacingAllMedium = EdgeInsets.all(sizeMedium);
  static EdgeInsets spacingAllLarge = EdgeInsets.all(sizeLarge);
  static EdgeInsets spacingAllExtraLarge = EdgeInsets.all(sizeExtraLarge);
  static EdgeInsets spacingAllXXL = EdgeInsets.all(sizeXXL);
  static EdgeInsets spacingAllXXXL = EdgeInsets.all(sizeXXXL);
  static EdgeInsets spacingAllUltraXXXL = EdgeInsets.all(sizeUltraXXXL);

  static EdgeInsets spacingOnlySmall =
      EdgeInsets.only(top: sizeSmall, bottom: sizeSmall);

  static void setDefaultSize(context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    sizeLarge = 20.0;
    sizeXL = 30.0;
    sizeXXL = 40.0;
    sizeXXXL = 50.0;
    sizeUltraXXXL = 65.0;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;
    screenWidthEleven = screenWidth / 11;
    screenWidthTwelve = screenWidth / 12;
    screenWidthThirteen = screenWidth / 13;
    screenWidthFourteen = screenWidth / 14;
    screenWidthFifteen = screenWidth / 15;
    screenWidthMinimum = screenWidth / 25;

    screenHeightHalf = screenHeight / 2;
    screenHeightThird = screenHeight / 3;
    screenHeightFourth = screenHeight / 4;
    screenHeightFifth = screenHeight / 5;
    screenHeightSixth = screenHeight / 6;
    screenHeightTenth = screenHeight / 10;
    screenHeightEleven = screenHeight / 11;
    screenHeightTwelve = screenHeight / 12;
    screenHeightThirteen = screenHeight / 13;
    screenHeightFourteen = screenHeight / 14;
    screenHeightFifteen = screenHeight / 15;
    screenHeightMinimum = screenHeight / 25;

    defaultIconSize = 80.0;
    defaultImageHeight = 120.0;
    snackBarHeight = 50.0;
    texIconSize = 30.0;

    defaultHelpBoxHeight = 226.8;
    defaultIndicatorWidth = screenWidthFourth;

    spacingAllDefault = EdgeInsets.all(sizeDefault);
    spacingAllSmall = EdgeInsets.all(sizeSmall);

    FontSize.setDefaultFontSize();
  }

  static void setScreenAwareConstant(context) {
    setDefaultSize(context);
    DeviceManager.instance = DeviceManager(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    sizeExtraSmall = DeviceManager.instance.setWidth(5.0);
    sizeDefault = DeviceManager.instance.setWidth(8.0);
    sizeSmall = DeviceManager.instance.setWidth(10.0);
    sizeMedium = DeviceManager.instance.setWidth(15.0);
    sizeLarge = DeviceManager.instance.setWidth(20.0);
    sizeMidLarge = DeviceManager.instance.setWidth(25.0);
    sizeXL = DeviceManager.instance.setWidth(30.0);
    sizeXXL = DeviceManager.instance.setWidth(40.0);
    sizeXXXL = DeviceManager.instance.setWidth(50.0);
    sizeUltraXXXL = DeviceManager.instance.setWidth(65.0);

    /*EdgeInsets*/
    spacingAllZero = const EdgeInsets.all(0);
    spacingAllDefault = EdgeInsets.all(sizeDefault);
    spacingAllExtraSmall = EdgeInsets.all(sizeExtraSmall);
    spacingAllSmall = EdgeInsets.all(sizeSmall);
    spacingAllMedium = EdgeInsets.all(sizeMedium);
    spacingAllLarge = EdgeInsets.all(sizeLarge);
    spacingAllExtraLarge = EdgeInsets.all(sizeExtraLarge);
    spacingAllXXL = EdgeInsets.all(sizeXXL);
    spacingAllXXXL = EdgeInsets.all(sizeXXXL);
    spacingAllUltraXXXL = EdgeInsets.all(sizeUltraXXXL);
    spacingOnlySmall = EdgeInsets.only(
      top: sizeSmall,
      bottom: sizeSmall,
    );

    /*Screen Size dependent Constants*/
    screenWidthHalf = DeviceManager.instance.width / 2;
    screenWidthThird = DeviceManager.instance.width / 3;
    screenWidthFourth = DeviceManager.instance.width / 4;
    screenWidthFifth = DeviceManager.instance.width / 5;
    screenWidthSixth = DeviceManager.instance.width / 6;
    screenWidthTenth = DeviceManager.instance.width / 10;

    /*Image Dimensions*/

    defaultIconSize = DeviceManager.instance.setWidth(80.0);
    miniIconSize = DeviceManager.instance.setWidth(66.0);
    defaultImageHeight = DeviceManager.instance.setHeight(120.0);
    snackBarHeight = DeviceManager.instance.setHeight(50.0);
    texIconSize = DeviceManager.instance.setWidth(30.0);

    /*Default Height&Width*/
    defaultHelpBoxHeight = DeviceManager.instance.setHeight(226.8);
    defaultSizeTwoFifty = DeviceManager.instance.setHeight(250);
    defaultSizeThreeTwenty = DeviceManager.instance.setHeight(320);
    defaultSizeFourFifty = DeviceManager.instance.setHeight(450);
    defaultSizeOneTwenty = DeviceManager.instance.setHeight(120);
    defaultSizeOneTen = DeviceManager.instance.setHeight(110);
    defaultIndicatorWidth = screenWidthFourth;

    /* Nimmio Default Height*/
    defaultHeightNinetyEight = DeviceManager.instance.setHeight(98.0);
    defaultHeightEightyTwo = DeviceManager.instance.setHeight(82.0);
    defaultHeightSeventySix = DeviceManager.instance.setHeight(76.0);
    defaultHeightNinety = DeviceManager.instance.setHeight(90.0);
    defaultHeightForty = DeviceManager.instance.setHeight(40.0);
    defaultHeightSixty = DeviceManager.instance.setHeight(60.0);
    defaultHeightTwentyThree = DeviceManager.instance.setHeight(23.0);
    defaultHeightFifteen = DeviceManager.instance.setHeight(15.0);
    defaultHeightTen = DeviceManager.instance.setHeight(10.0);
    defaultHeightSeventy = DeviceManager.instance.setHeight(70.0);
    defaultHeightOneThirty = DeviceManager.instance.setHeight(130.0);
    defaultHeightOneForty = DeviceManager.instance.setHeight(140.0);
    defaultHeightOneFifty = DeviceManager.instance.setHeight(150.0);
    defaultHeightOneEighty = DeviceManager.instance.setHeight(180.0);
    defaultHeightOneHundred = DeviceManager.instance.setHeight(100.0);
    defaultHeightTwoHundred = DeviceManager.instance.setHeight(200.0);
    defaultHeightTwoHundredFifty = DeviceManager.instance.setHeight(350.0);
    defaultHeightTwoHundredThirty = DeviceManager.instance.setHeight(230.0);
    /* Nimmio Default Width*/
    defaultWidthNinetyEight = DeviceManager.instance.setWidth(98.0);
    defaultWidthOneEighty = DeviceManager.instance.setWidth(180.0);
    defaultWidthOneSeventy = DeviceManager.instance.setWidth(170.0);
    defaultWidthThreeThirtySix = DeviceManager.instance.setWidth(336.0);
    defaultWidthOneHundredSeven = DeviceManager.instance.setWidth(107.0);
    defaultWidthSixty = DeviceManager.instance.setWidth(60.0);
    defaultWidthTen = DeviceManager.instance.setWidth(10.0);
    defaultWidthTwenty = DeviceManager.instance.setWidth(20.0);
    defaultWidthOneNinety = DeviceManager.instance.setWidth(210.0);
  }
}

class FontSize {
  static double s7 = 7.0;
  static double s8 = 8.0;
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s19 = 19.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s23 = 23.0;
  static double s24 = 24.0;
  static double s25 = 25.0;
  static double s26 = 26.0;
  static double s27 = 27.0;
  static double s28 = 28.0;
  static double s29 = 29.0;
  static double s30 = 30.0;
  static double s36 = 36.0;

  static setDefaultFontSize() {
    s7 = 7.0;
    s8 = 8.0;
    s9 = 9.0;
    s10 = 10.0;
    s11 = 11.0;
    s12 = 12.0;
    s13 = 13.0;
    s14 = 14.0;
    s15 = 15.0;
    s16 = 16.0;
    s17 = 17.0;
    s18 = 18.0;
    s19 = 19.0;
    s20 = 20.0;
    s21 = 21.0;
    s22 = 22.0;
    s23 = 23.0;
    s24 = 24.0;
    s25 = 25.0;
    s26 = 26.0;
    s27 = 27.0;
    s28 = 28.0;
    s29 = 29.0;
    s30 = 30.0;
    s36 = 36.0;
  }

  static setScreenAwareFontSize() {
    s7 = DeviceManager.instance.setSp(7.0);
    s8 = DeviceManager.instance.setSp(8.0);
    s9 = DeviceManager.instance.setSp(9.0);
    s10 = DeviceManager.instance.setSp(10.0);
    s11 = DeviceManager.instance.setSp(11.0);
    s12 = DeviceManager.instance.setSp(12.0);
    s13 = DeviceManager.instance.setSp(13.0);
    s14 = DeviceManager.instance.setSp(14.0);
    s15 = DeviceManager.instance.setSp(15.0);
    s16 = DeviceManager.instance.setSp(16.0);
    s17 = DeviceManager.instance.setSp(17.0);
    s18 = DeviceManager.instance.setSp(18.0);
    s19 = DeviceManager.instance.setSp(19.0);
    s20 = DeviceManager.instance.setSp(20.0);
    s21 = DeviceManager.instance.setSp(21.0);
    s22 = DeviceManager.instance.setSp(22.0);
    s23 = DeviceManager.instance.setSp(23.0);
    s24 = DeviceManager.instance.setSp(24.0);
    s25 = DeviceManager.instance.setSp(25.0);
    s26 = DeviceManager.instance.setSp(26.0);
    s27 = DeviceManager.instance.setSp(27.0);
    s28 = DeviceManager.instance.setSp(28.0);
    s29 = DeviceManager.instance.setSp(29.0);
    s30 = DeviceManager.instance.setSp(30.0);
    s36 = DeviceManager.instance.setSp(36.0);
  }
}
