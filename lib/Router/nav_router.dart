import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:crypto_ticker/Views/asset_data_view.dart';
import 'package:crypto_ticker/Views/login_screen.dart';
import 'package:get/route_manager.dart';

import '../Views/initial_screen.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(
      name: initalScreen,
      page: () => InitialScreen(),
    ),
    GetPage(
      name: assetDataHistory,
      page: () => AssetDataView(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
  ];
}
