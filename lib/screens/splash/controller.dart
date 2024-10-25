import 'package:get/get.dart';

import '../../pages/routes.dart';

class SplashController extends GetxController {
  SplashController();
  RxList itemData = [].obs;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.home);
    });
    super.onInit();
  }
}
