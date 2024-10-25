// ignore_for_file: use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_widgets.dart';
import 'controller.dart';
import 'utils/test.dart';

class MyHome extends GetView<MyHomeController> {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    const Color blue = Color.fromARGB(255, 13, 105, 204);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        child: Icon(
          Icons.settings,
          color: Colors.white,
          size: 50,
        ),
        onPressed: () {
          Get.to(Settings());
        },
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/frame.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height / 20),
            Image.asset(
              height: screenSize.height / 10,
              color: Colors.white,
              'assets/images/luvpark.png',
            ),
            SizedBox(height: screenSize.height / 30),

            /// Lottie.asset('assets/images/sender.json', width: 300, height: 300),
            SizedBox(height: 30),
            DefaultTextStyle.merge(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              child: IconTheme.merge(
                data: const IconThemeData(color: Colors.white),
                child: Obx(
                  () => AnimatedToggleSwitch<bool>.dual(
                    current: controller.positive.value,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 600),
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    styleBuilder: (value) => ToggleStyle(
                      backgroundColor: value
                          ? blue
                          : const Color.fromARGB(255, 197, 220, 232),
                    ),
                    borderWidth: 6.0,
                    height: 60.0,
                    loadingIconBuilder: (context, global) =>
                        CupertinoActivityIndicator(
                            color: Color.lerp(
                                Colors.red[800], blue, global.position)),
                    onChanged: (b) => controller.toggleService(b),
                    iconBuilder: (value) => value
                        ? const Icon(Icons.lightbulb_outline_rounded,
                            color: blue, size: 28.0)
                        : Icon(Icons.power_settings_new_rounded,
                            color: Colors.red[800], size: 30.0),
                    textBuilder: (value) => value
                        ? const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('Active'))
                        : const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text('Inactive')),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomTitle(
              color: Colors.white,
              title: "luvpark SMS Sender",
            ),
            Obx(() => CustomTitle(
                  color: Colors.white,
                  title: controller.positive.value == true
                      ? "is currently working"
                      : "is offline",
                )),
          ],
        ),
      ),
    );
  }
}
