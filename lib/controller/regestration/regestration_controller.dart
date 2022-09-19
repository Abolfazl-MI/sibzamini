import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sibzamini/views/views.dart';

class RegistrationController extends GetxController {
  int timeLaps = 60;
  bool isEnable = false;
  Rx<String> errorMessage = ''.obs;
  Rx<bool> hadSendCodeBefore = false.obs;
  bool isLoading = false;
  // used for validating phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = 'شماره‌تلفن‌برای ‌ورود‌الزامی‌است ';
      return 'شماره‌تلفن‌برای ‌ورود‌الزامی‌است ';
    } else if (!value.isValidIranianMobileNumber()) {
      return 'شماره‌تلفن‌را‌درست‌وارد‌کنید';
    }
    return null;
  }

  validPenCode(String? value) {
    if (value!.length >=4) {
      isEnable = true;
      update();
    } else {
      isEnable = false;
      update();
    }
  }

  sendVerfiyCode() async {
    isLoading = true;
    update();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    resendVerfiyCode();
    Get.offAndToNamed(AppRoutesName.verifyCodeScreen);
  }

  resendVerfiyCode() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      timeLaps = timeLaps - 1;
      update();
      if (timeLaps == 0) {
        timer.cancel();
        update();
      }
      print(timeLaps);
    });
    if (timeLaps == 0) {
      timeLaps = 50;
      update();

      // TODO: RESIND FUNCTIONALITY  HERE
      print('sended code');
    }
    update();
  }
}
