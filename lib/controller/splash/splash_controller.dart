import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class SplashScreenController extends GetxController {
  final SharedStorageService _storageService = SharedStorageService();
  final LocationServices _locationServices = LocationServices();
  final InternetConnectivityService _internetConnectivityService =
      InternetConnectivityService();

  /// [splash screen checls for login or not]

  _getUserLocation() async {
    DataState<String> userLocation =
        await _locationServices.getUserCityLocation();
    if (userLocation is DataSuccesState) {
      return userLocation;
    }
    if (userLocation is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'location_error': userLocation.error});
    }
  }

  Future<void> _splashScreenDecition() async {
    DataState<bool> isInterNetEnabled =
        await _internetConnectivityService.isInterNetEnabled();
    if (isInterNetEnabled is DataSuccesState) {
      bool checkUserLogin = await _storageService.checkLogin();
      if (checkUserLogin) {
        String userLocation = _getUserLocation();
        Get.off(rHomeScreen, arguments: {'city': userLocation});
      } else {
        Get.offNamed(rLoginScreen);
      }
    }
    if (isInterNetEnabled is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'splash_error': isInterNetEnabled.error});
    }
  }

  @override
  void onInit() {
    super.onInit();
    _splashScreenDecition();
  }
}
