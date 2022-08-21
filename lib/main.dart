import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Router/nav_router.dart';
import 'Router/route_constants.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Used for using widgets before initializing the app
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    //Used for setting the orientation of the app
    runApp(const CryptoTicker()); //Used for running the app
  });
}

class CryptoTicker extends StatelessWidget {
  const CryptoTicker({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //Since we ae using GetX as state management framework, we need to use GetMaterialApp
      builder: (context, widget) => ResponsiveWrapper.builder(
          //Used for setting the responsive design of the app
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 2460,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      initialRoute: initalScreen, //The 1st route when the app is launched.
      defaultTransition:
          Transition.native, //Used for setting the transition of the app
      getPages:
          NavRouter.generateRoute, //Used for setting the routes of the app
      title: 'Crypto Ticker', //Used for setting the title of the app
      theme: ThemeData(
        //Used for setting the theme of the app
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
