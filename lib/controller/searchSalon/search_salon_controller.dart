import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/location_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_services.dart';

class SearchSalonsController extends GetxController {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.disconnected;

  // late final StreamSubscription<ConnectivityStatus> _subscription;
  List<City> avaliableCities = [];
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  String? userCityLocation;
  final Rx<String> _searchQuery = Rx<String>('');
  bool isSearchLoading = false;
  List<Salon> searchResult = [];

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

  Future<void> _getUserCityLocation() async {
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
        } else {
          userCityLocation = 'تهران';
          update();
        }
      });
    }
  }

  void updateUserCityLocation(String cityName) {
    userCityLocation = cityName;
    update();
  }

  autoSelectLocation()async{
    await LocationServices().getUserCityLocation().then((DataState dataState) {
      if(dataState is DataSuccesState){
        userCityLocation=dataState.data;
        update();
      }
      if(dataState is DataFailState){
        userCityLocation='Tehran';
        update();
      }
    });
  }

  Future<void> _searchSalon(String query) async {
    isSearchLoading = true;
    update();
    print(userCityLocation);
    if (userCityLocation == null) _getUserCityLocation();
    if(query.isNotEmpty){
      await _apiServices
        .getSalonBySearch(query: query.trim(), city: userCityLocation ?? 'تهران')
        .then((DataState dataState) {
          if(dataState is DataSuccesState){
            searchResult=dataState.data;
            isSearchLoading=false;
            update();
          }else{
            isSearchLoading=false;
            searchResult=[];
            update();
          }
    });
    }
    
  }

  clearSrarchResult(){
    searchResult.clear();
    update();
  }

  updateSerchQuery(String query) {
    _searchQuery.value = query;
  }

  @override
  void onInit() {
    debounce(_searchQuery, _searchSalon,
        time: const Duration(milliseconds: 1000));
    super.onInit();
    _getAvailableCities();
    _getUserCityLocation();
  }
}
