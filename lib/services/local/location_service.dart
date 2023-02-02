import 'package:geolocator/geolocator.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'dart:developer';

import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/global/constants/iran_cities_names.dart';

class LocationServices {
  final ApiServices _apiServices = ApiServices();
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
      if (locationPermission == LocationPermission.deniedForever) {
        return DataFailState(LOCATION_ACCESS_DENIDD);
      }
      currentPossition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      
      DataState<String> persianCityName =
          await _apiServices.getUserCityLocation(
              lat: currentPossition.latitude, lon: currentPossition.longitude);
      if(persianCityName is DataSuccesState){
        // log(persianCityName.data.toString());
        print(persianCityName.data);
        log('[Persian CityLocation]=> ${persianCityName.data}');
        // iranCities.firstWhere((element) => element['title']==userPersianCity.data)['slug'];
        String finalCityName=iranCities.firstWhere((element) => element['title']==persianCityName.data)['slug'];
        log('[USER CITY LOCATION]=> $finalCityName');
        return DataSuccesState(finalCityName);
      }
      if(persianCityName is DataFailState){
        return DataFailState(persianCityName.error!);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      print(e);
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }
}
