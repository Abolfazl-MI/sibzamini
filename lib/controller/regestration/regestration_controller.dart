import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sibzamini/core/data_staes.dart';

import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/services/local/location_service.dart';
import 'package:sibzamini/models/services/local/shared_service.dart';
import 'package:sibzamini/models/services/remote/api_services.dart';
import 'package:sibzamini/models/user_model/user_modle.dart';
import 'package:sibzamini/views/views.dart';

class RegistrationController extends GetxController {
  final SharedStorageService _sharedStorageService = SharedStorageService();
  final ApiServices _apiServices = ApiServices();
  final LocationServices _locationServices = LocationServices();
  int timeLaps = 60;
  bool isEnable = false;
  Rx<String> errorMessage = ''.obs;
  Rx<bool> hadSendCodeBefore = false.obs;
  bool isLoading = false;
  // used for validating phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = PHONE_NUMBER_REQUIRED;
      return PHONE_NUMBER_REQUIRED;
    } else if (!value.isValidIranianMobileNumber()) {
      return PHONE_NUMBER_INVALID;
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

  //sends otp code for first time
  sendVerfiyCode() async {
    isLoading = true;
    update();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    resendVerfiyCode();
    Get.offAndToNamed(rVerifyCodeScreen);
  }

  // resends the otp code
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

  // registerUser

  createUserAccount({
    required String name,
    required String phoneNumber,
  }) async {
    isLoading = true;
    update();
    DataState<String> city = await _locationServices.getUserCityLocation();
    if (city is DataFailState) {
      _apiServices.cancleRequest();
      isLoading = false;
      update();
      if (city.error == LOCATION_ACCESS_DENIDD) {
        Get.snackbar('\u{1F610}' 'دسترسی مکان محدود شد', LOCATION_ACCESS_DENIDD,
            backgroundColor: Colors.red);
      }
      if (city.error == DISSABLED_LOCATION_SERVICE) {
        Get.snackbar(
            '\u{1F610}' 'سرویس مکان یابی روشن نیست', DISSABLED_LOCATION_SERVICE,
            backgroundColor: Colors.red);
      }
    }
    FormData data = FormData.fromMap(
        {'name': name, 'mobile': phoneNumber, 'city': city.data});
    DataState<User> result = await _apiServices.createUserAccount(data: data);
    if (result is DataSuccesState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F642}' 'موفقیت امیز بود', 'شما وارد شدید،خوش آمدید',
          backgroundColor: Colors.green);
      await _sharedStorageService.saveUserToken(result.data!.token!);
      Get.offNamed(rHomeScreen, arguments: {'user': result.data});
    }
    if (result is DataFailState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش اومده', SOMETHING_WENT_WRONG,
          backgroundColor: Colors.red);
    }
  }

  requestLoginUser({required String phoneNumber}) async {
    isLoading = true;
    update();
    FormData data = FormData.fromMap({'mobile': phoneNumber});
    DataState<bool> result = await _apiServices.loginUserAccount(data: data);
    if(result is DataSuccesState){
      isLoading=false;
      update();
      Get.snackbar('\u{1F642}' 'موفقیت آمیز بود', 'کد احراز هویت برای شما ارسال شد',
          backgroundColor: Colors.green);
      Get.offNamed(rVerifyCodeScreen);
    }
    if(result is DataFailState){
      isLoading=false;
      update();
       Get.snackbar('\u{1F610}' 'مشکلی پیش اومده', result.error!,
          backgroundColor: Colors.red);
    }
  }
}
