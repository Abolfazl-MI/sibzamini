import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_services.dart';

class SearchSalonsController extends GetxController {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.disconnected;
  late final StreamSubscription<ConnectivityStatus> _subscription;

  List<City> avaliableCities = [];
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  String? userCityLocation;

  _updateConnecttivityStatus(ConnectivityStatus status) {
    print(status);
    connectivityStatus = status;
    update();
  }

  _getAvailableCities() async {
    await _apiServices.getAvailableCities().then((DataState dataState) {
      if (dataState is DataSuccesState) {
        avaliableCities = dataState.data;
        update();
      }
      if (dataState is DataFailState) {
        Get.snackbar('مشکلی پیش امده لطفا دوباره تلاش کنید', dataState.error!,
            backgroundColor: Colors.red);
      }
    });
  }

  _getUserCityLocation() async {
    String? city = await _storageService.getUserCity();
    if (city != null) {
      userCityLocation = city;
      update();
    } else {
      await LocationServices()
          .getUserCityLocation()
          .then((DataState dataState) async {
        if (dataState is DataSuccesState) {
          await _storageService.saveUserCity(dataState.data);
          userCityLocation = dataState.data;
          update();
        }else{
          userCityLocation='تهران';
          update();
        }
      });
    }
  }

  updateUserCityLocation(String cityName){
    userCityLocation=cityName;
    update();
  }

  // srarchSalon(String query) async {
  //   await _apiServices.getSalonBySearch(query: query, city: userCityLocation!).then((DataState dataSte));
  // }

  @override
  void onInit() {
    super.onInit();
    _subscription = InternetConnectivityService()
        .connectivityResultStream()
        .listen((event) => _updateConnecttivityStatus(event));
    _getAvailableCities();
    _getUserCityLocation();
  }

  @override
  void onClose() async {
    await _subscription.cancel();
    super.onClose();
  }
}
