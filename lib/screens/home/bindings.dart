import 'package:get/get.dart';

import 'controller.dart';

class MyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyHomeController>(() => MyHomeController());
  }
}
