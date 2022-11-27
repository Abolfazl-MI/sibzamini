import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sibzamini/core/data_staes.dart';

class LocationServices {


  Future<DataState<String>> getUserCityLocation() async {
    bool? isServcesEnabled;
    Position? currentPossition;
    LocationPermission locationPermission;
    try {
      isServcesEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServcesEnabled) {
        return DataFailState('Location Service is not Enable');
      }
      locationPermission = await Geolocator.checkPermission();
      switch (locationPermission) {
        case LocationPermission.denied:
          locationPermission = await Geolocator.requestPermission();
          break;
        case LocationPermission.deniedForever:
          return DataFailState('Location Persmission Required !');
      }
      currentPossition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPossition.latitude, currentPossition.longitude);
      Placemark current_city=placemarks[0];
      return DataSuccesState(current_city.locality);
    } catch (e) {
      return DataFailState(e.toString());
    }
  }
}
