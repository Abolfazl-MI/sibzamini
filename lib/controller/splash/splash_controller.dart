import 'package:app_settings/app_settings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/views/global/colors/colors.dart';
import 'package:sibzamini/views/global/constants/app_text_themes.dart';
import 'package:sibzamini/views/global/widgets/location_error_dialog.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class SplashScreenController extends FullLifeCycleController with FullLifeCycleMixin {
  final SharedStorageService _storageService = SharedStorageService();
  final LocationServices _locationServices = LocationServices();
  final InternetConnectivityService _internetConnectivityService =
      InternetConnectivityService();
  Future<void> _splashScreenDecition() async {
    await Future.delayed(const Duration(seconds: 1));
    DataState<bool> isInterNetEnabled =
        await _internetConnectivityService.isInterNetEnabled();
    if (isInterNetEnabled is DataSuccesState) {
      bool checkUserLogin = await _storageService.checkLogin();
      if (checkUserLogin) {
        // ! should get user currennt city location
        DataState<String> cityState =
            await _locationServices.getUserCityLocation();
        if (cityState is DataSuccesState) {
          Get.offNamed(AppRoutes.rHomeScreen,
              arguments: {'city': cityState.data});
        }
        if (cityState is DataFailState) {
          showLocationErrorDialog(cityState.error!);
        }
      } else {
        Get.offNamed(AppRoutes.rLoginScreen);
      }
    }
    if (isInterNetEnabled is DataFailState) {
      Get.offNamed(AppRoutes.rErrorScreen,
          arguments: {'error': isInterNetEnabled.error});
    }
  }

  @override
  void onResumed()async {
    // TODO: implement onResumed
    print('on Resume called');
    _splashScreenDecition();
  }  

    

  @override
  void onInit() {
    super.onInit();
    _splashScreenDecition();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    print('on Detached called');
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print('onInactive called');
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print('onPause called');
  }
}

