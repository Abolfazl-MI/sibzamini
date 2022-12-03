import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'dart:developer';

class LocationServices {
  Future<DataState<String>> getUserCityLocation() async {
    log('********Getting user location********');
    bool? isServcesEnabled;
    Position? currentPossition;
    LocationPermission locationPermission;
    try {
      isServcesEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServcesEnabled) {
        return DataFailState(DISSABLED_LOCATION_SERVICE);
      }
      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      }
      if(locationPermission == LocationPermission.deniedForever){
        return DataFailState(LOCATION_ACCESS_DENIDD);
      }
      currentPossition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPossition.latitude, currentPossition.longitude);
      Placemark current_city = placemarks[0];
      return DataSuccesState(current_city.locality);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  Future requestPermission() async {}
}
