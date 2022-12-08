import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
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
      await _storageService.saveUserCity(userLocation.data!);
      return userLocation;
    }
    if (userLocation is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'error': userLocation.error});
    }
  }

  Future<void> _splashScreenDecition() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
    DataState<bool> isInterNetEnabled =
        await _internetConnectivityService.isInterNetEnabled();
    if (isInterNetEnabled is DataSuccesState) {
      bool checkUserLogin = await _storageService.checkLogin();
      if (checkUserLogin) {
        // String userLocation = _getUserLocation();
        // ! should get user currennt city location
        Get.offNamed(rHomeScreen, arguments: {'city': 'Tehran'});
      } else {
        Get.offNamed(rLoginScreen);
      }
    }
    if (isInterNetEnabled is DataFailState) {
      Get.offNamed(rErrorScreen,
          arguments: {'error': isInterNetEnabled.error});
    }
  }

  @override
  void onInit() {
    super.onInit();
    _splashScreenDecition();
  }
}
