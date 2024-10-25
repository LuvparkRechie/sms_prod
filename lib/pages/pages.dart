import 'package:get/get.dart';

import '../screens/home/index.dart';
import '../screens/splash/index.dart';
import 'routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => const Splash(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => const MyHome(),
        binding: MyHomeBinding()),
  ];
}
