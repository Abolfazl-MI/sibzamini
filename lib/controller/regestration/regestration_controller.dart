import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart' hide FormData;

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/user_model/user_modle.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/views.dart';

class RegistrationController extends GetxController {
  final SharedStorageService _sharedStorageService = SharedStorageService();
  final ApiServices _apiServices = ApiServices();
  final LocationServices _locationServices = LocationServices();
  int timeLaps = 60;
  bool isEnable = false;
  int maxResendCode = 3;
  Rx<String> errorMessage = ''.obs;
  Rx<bool> hadSendCodeBefore = false.obs;
  bool isLoading = false;
  // used for validating phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = PHONE_NUMBER_REQUIRED;
      return PHONE_NUMBER_REQUIRED;
    }
    if (value.length < 11) {
      errorMessage.value = 'شماره وارد شده صحیح نمیباشد';
      return 'شماره وارد شده صحیح نمیباشد';
    }
    return null;
  }

  // validats userName
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = NAME_REQUIRED;
      return NAME_REQUIRED;
    } else if (value.length < 2) {
      errorMessage.value = NAME_INVALID;
      return NAME_INVALID;
    }
    return null;
  }

  // validatest the pin code
  validPenCode(String? value) {
    if (value!.length >= 4) {
      isEnable = true;
      update();
    } else {
      isEnable = false;
      update();
    }
  }

  // resends the otp code
  Future<void> resendVerfiyCodeTimer() async {
    if (maxResendCode == 0) {
      Get.snackbar(
          '\u{1F641}' ' یکم صبر کنید  ', 'لطفا کمی صبر کنید ،دوباره تلاش کنید ',
          backgroundColor: Colors.red);
      await Future.delayed(Duration(seconds: 5), () {
        maxResendCode = 3;
        update();
      });
    }
    if (timeLaps == 0 && maxResendCode > 0) {
      maxResendCode = maxResendCode - 1;
      update();
      // await _apiServices.loginUserAccount(phoneNumber: Get.arguments['mobile']);
      timeLaps = 50;
      update();
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLaps = timeLaps - 1;
      update();
      if (timeLaps == 0) {
        timer.cancel();
        update();
      }
      // print(timeLaps);
    });
  }

  // registerUser
  Future<void> createUserAccount({
    required String name,
    required String phoneNumber,
  }) async {
    isLoading = true;
    update();
    DataState<User> result = await _apiServices.createUserAccount(
        name: name, phoneNumber: phoneNumber, city: 'tehran');
    if (result is DataSuccesState) {
      await _apiServices.requestOtpCode(phoneNumber: phoneNumber);
      isLoading = false;
      update();
      Get.snackbar(
          '\u{1F642}' 'موفقیت آمیز بود', 'کد احراز هویت برای شما ارسال شد',
          backgroundColor: Colors.green);
      await _sharedStorageService.saveUserToken(result.data!.token!);
      Get.offNamed(rVerifyCodeScreen, arguments: {'mobile': phoneNumber});
    }
    if (result is DataFailState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش اومده', result.error!,
          colorText: Colors.white,
          backgroundColor: Color.fromARGB(255, 236, 100, 90));
    }
    // }
  }

  Future<void> requestLoginUser({required String phoneNumber}) async {
    isLoading = true;
    update();
    DataState<bool> result =
        await _apiServices.requestOtpCode(phoneNumber: phoneNumber);
    if (result is DataSuccesState) {
      isLoading = false;
      update();
      Get.snackbar(
          '\u{1F642}' 'موفقیت آمیز بود', 'کد احراز هویت برای شما ارسال شد',
          backgroundColor: Colors.green);
      await Future.delayed(const Duration(seconds: 3));
      Get.offNamed(rVerifyCodeScreen, arguments: {'mobile': phoneNumber});
    }
    if (result is DataFailState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش اومده', result.error!,
          backgroundColor: Colors.red);
    }
  }

  Future<void> confirmOtpCode(
      {required String otpCode, required String phoneNumber}) async {
    isLoading = true;
    update();
    DataState<User> resualt = await _apiServices.confirmUserOtp(
        otpCode: otpCode, phoneNumber: phoneNumber);
    if (resualt is DataSuccesState) {
      await _sharedStorageService.saveUserToken(resualt.data!.token!);

      Get.snackbar('\u{1F642}' 'موفقیت امیز بود', 'شما وارد شدید،خوش آمدید',
          backgroundColor: Colors.green);
      // await Future.delayed(Duration(seconds: 3));
      DataState<String> cityState =
          await _locationServices.getUserCityLocation();
      if (cityState is DataSuccesState) {
        isLoading = false;
        update();
        await _sharedStorageService.saveUserCity(cityState.data!);
        Get.offNamed(rHomeScreen, arguments: {'city': cityState.data});
      } else {
        Get.snackbar('مشکلی پیش آمده',
            'مشکلی در تشخیص مکان شما پیش امده لطفا دستی خودتان انتخاب کنید ');
        Get.offNamed(rHomeScreen, arguments: {'city': 'Tehran'});
      }
    }
    if (resualt is DataFailState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش اومده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }
}
