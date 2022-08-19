import 'package:crypto_ticker/Router/route_constants.dart';
import 'package:get/route_manager.dart';

import '../Views/initial_screen.dart';

class NavRouter {
  static final generateRoute = [
    GetPage(
      name: initalScreen,
      page: () => const InitialScreen(),
    ),
  ];
}
