// ignore_for_file: prefer_const_constructors, unnecessary_overrides, unused_local_variable

import 'package:background_sms/background_sms.dart';
import 'package:get/get.dart';
import 'package:get_phone_number/get_phone_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http/api_service.dart';
import '../../http/http.dart';

class MyHomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool positive = false.obs;
  RxBool isServiceRunning = false.obs;
  var message = ''.obs;
  var number = "".obs;
  @override
  void onInit() {
    loadToggleState();
    getPhoneNumber();
    super.onInit();
  }

  // =================================================
  @override
  void onClose() {
    saveToggleState(positive.value);
    super.onClose();
  }

  Future<void> saveToggleState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('serviceStatus', value);
  }

  // =================================================
  Future<void> loadToggleState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    positive.value = prefs.getBool('serviceStatus') ?? false;
    if (positive.value) {
      startService();
    }
  }

  // =================================================
  void toggleService(bool value) {
    positive.value = value;
    saveToggleState(value);
    if (value) {
      if (!isServiceRunning.value) {
        startService();
      }
    } else {
      if (isServiceRunning.value) {
        stopService();
      }
    }
  }

  // =================================================
  void startService() {
    isServiceRunning.value = true;
    smsPS();
    smsLP();
  }

  void stopService() {
    isServiceRunning.value = false;
  }

  // =================================================
  Future<void> smsLP() async {
    if (!isServiceRunning.value) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await GetPhoneNumber().get();
    var myMobile = result;
    var inatay = myMobile.toString().replaceAll("+", "");
    String subApi = "${ApiKeys.gApiSubFolderGetSmsLP}?mobile_no=$inatay";
    final response = await HttpRequest(
        api: ApiKeys.gApiSubFolderGetSmsLP,
        parameters: {"mobile_no": inatay}).post();

    if (response == "No Internet") {
      await Future.delayed(const Duration(seconds: 2));
      smsLP();
      return;
    }
    if (response["success"] == 'Y') {
      await Future.delayed(const Duration(seconds: 2));
      final response2 = await HttpRequest(api: subApi).get();
      print("response2 $response2");
      if (response2 == "No Internet") {
        await Future.delayed(const Duration(seconds: 2));
        smsLP();
        return;
      }
      if (response2["items"].isNotEmpty) {
        for (var dataRow in response2["items"]) {
          sendMessageLP(
            dataRow["mobile_no"].toString(),
            dataRow["sms_text"].toString(),
            dataRow["notification_id"],
            dataRow["sms_status"].toString(),
            dataRow["sender_mobile_no"].toString(),
          );
        }
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    smsLP();
  }

  Future<void> smsPS() async {
    if (!isServiceRunning.value) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await GetPhoneNumber().get();
    var myMobile = result;
    var inatay = myMobile.toString().replaceAll("+", "");
    String subApi = "${ApiKeys.gApiSubFolderGetSmsPS}?mobile_no=$inatay";
    final response = await HttpRequest(
        api: ApiKeys.gApiSubFolderGetSmsPS,
        parameters: {"mobile_no": inatay}).post();
    // print("response11 $response");
    if (response == "No Internet") {
      await Future.delayed(const Duration(seconds: 2));
      smsPS();
      return;
    }
    if (response["success"] == 'Y') {
      await Future.delayed(const Duration(seconds: 2));
      final response2 = await HttpRequest(api: subApi).get();
      // print("response22 $response2");
      if (response2 == "No Internet") {
        await Future.delayed(const Duration(seconds: 2));
        smsPS();
        return;
      }
      if (response2["items"].isNotEmpty) {
        for (var dataRow in response2["items"]) {
          sendMessagePS(
            dataRow["mobile_no"].toString(),
            dataRow["sms_text"].toString(),
            dataRow["notification_id"],
            dataRow["sms_status"].toString(),
            dataRow["sender_mobile_no"].toString(),
          );
        }
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    smsPS();
  }
  // =================================================

  sendMessageLP(
    String phoneNumber,
    String message,
    int notifId,
    String status,
    String phoneSender,
  ) async {
    var putParam = {"sms_status": "S", "notification_id": notifId};
    final response = await HttpRequest(
            api: ApiKeys.gApiSubFolderGetSmsLP, parameters: putParam)
        .put();
    print(" lpresponse $response");
    if (response["success"] == 'Y') {
      var result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber, message: message);
    }
  }

  sendMessagePS(
    String phoneNumber,
    String message,
    int notifId,
    String status,
    String phoneSender,
  ) async {
    var putParam = {"sms_status": "S", "notification_id": notifId};
    SharedPreferences pref = await SharedPreferences.getInstance();
    var myMobile = pref.getString('myNumber');
    String subApi = "${ApiKeys.gApiSubFolderGetSmsPS}?mobile_no=$myMobile";
    final response = await HttpRequest(api: subApi, parameters: putParam).put();

    if (response["success"] == 'Y') {
      var result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber, message: message);
    }
  }

// =================================================

  Future<void> getPhoneNumber() async {
    final result = await GetPhoneNumber().get();
    number.value = result;
  }

  // Future<void> hasPermission() async {
  //   final result = await GetPhoneNumber().hasPermission();
  //   message.value = 'has permission: $result';
  // }

  // Future<void> requestPermission() async {
  //   final result = await GetPhoneNumber().requestPermission();
  //   message.value = 'request permission: $result';
  // }
}
