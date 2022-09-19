import 'dart:async';

import 'package:get/get.dart';

class RegistrationController extends GetxController {
  Rx<int> timeLaps = 60.obs;
  Rx<String> errorMessage = ''.obs;
  Rx<bool> hadSendCodeBefore = false.obs;
  // used for validating phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = 'شماره‌تلفن‌برای ‌ورود‌الزامی‌است ';
      return 'شماره‌تلفن‌برای ‌ورود‌الزامی‌است ';
    } else if (value.length > 11) {
      errorMessage.value = "شماره‌موبایل‌اشتباه‌است";
      return "شماره‌موبایل‌اشتباه‌است";
    } else if (!value.contains('09')) {
      errorMessage.value = "شماره‌وارد‌شده‌صحیح‌نمیباشد";
      return "شماره‌وارد‌شده‌صحیح‌نمیباشد";
    }
    return null;
  }

  resendVerfiyCode() async {
    await Timer.periodic(Duration(seconds: 1), (timer) {
      timeLaps.value - 1;
    });
    if (timeLaps.value == 0) {
      timeLaps.value = 60;
      // TODO: RESIND FUNCTIONALITY  HERE
      print('sended code');
    }
  }
}
