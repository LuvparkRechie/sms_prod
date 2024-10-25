// ignore_for_file: sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/custom_widgets.dart';
import '../controller.dart';

class Settings extends StatelessWidget {
  final MyHomeController controller = Get.find<MyHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSubTitle(title: "Registered Number:"),
                CustomTitle(title: controller.number.value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
