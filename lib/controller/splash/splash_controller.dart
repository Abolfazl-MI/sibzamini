import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/services/local/location_service.dart';
import 'package:sibzamini/models/services/local/shared_service.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class SplashScreenController extends GetxController {
  final SharedStorageService _storageService = SharedStorageService();
  final LocationServices _locationServices = LocationServices();
  /// [splash screen checls for login or not] 
  Future checkUserAuthAndGetLocation() async {
    bool userExists = await _storageService.checkLogin();
    if (userExists) {
      DataState<String> userLocation =
          await _locationServices.getUserCityLocation();
      if (userLocation is DataSuccesState) {
        Get.offNamed(rHomeScreen, arguments: {'city': userLocation.data});
      }
      if (userLocation is DataFailState) {
        switch (userLocation.error) {
          case DISSABLED_LOCATION_SERVICE:
            Get.snackbar('مشکلی پیش اومده', userLocation.error!);
            break;
          case LOCATION_ACCESS_DENIDD:
            Get.offNamed(
              rErrorScreen,
              arguments: {'error': userLocation.error},
            );
            break;
          case SOMETHING_WENT_WRONG:
            Get.offNamed(
              rErrorScreen,
              arguments: {'error': userLocation.error},
            );
            break;
        }
      }
    } else {
      Get.offNamed(rLoginScreen);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkUserAuthAndGetLocation();
  }
}
