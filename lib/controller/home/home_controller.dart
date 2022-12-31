import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';

class HomeController extends GetxController {
  // dependencies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  
  // variables
  List<Salon> bestSalonsList = [];
  List<Salon> newestSalonList = [];
  List<Salon> salonsBasedOnCategory = [];
  List<ServiceCategory> salonCategories = [];
  List<BookMarkedSalon> bookMarkedSalons = [];
  List<City>availableCities=[];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isCategoryLoadign = false;
  ConnectivityStatus connectivityStatus = ConnectivityStatus.disconnected;
  late final StreamSubscription<ConnectivityStatus> _subscription;
  //methods
  // get best Salons
  Future<void> getBestSalons({required String cityName}) async {
    // isLoading = true;
    // update();
    DataState<List<Salon>> result =
        await _apiServices.getSalonList(cityName: cityName, path: bestSalons);
    if (result is DataSuccesState) {
      // print(result.data);
      if (result.data != null) {
        bestSalonsList = result.data!;
        // isLoading = false;
        update();
      }
    }
    if (result is DataFailState) {
      // print(result.error);

      // isLoading = false;
      // update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
          backgroundColor: Colors.red);
    }
  }

  // get news Salons
  Future<void> getNewesSalons({required String cityName}) async {
    DataState<List<Salon>> resualt =
        await _apiServices.getSalonList(cityName: cityName, path: newestSalon);
    // print('{data:$}');

    if (resualt is DataSuccesState) {
      // print(resualt.data);
      if (resualt.data != null) {
        newestSalonList = resualt.data!;
        update();
      }
    }
    if (resualt is DataFailState) {
      // print(resualt);
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }

  // search Salons
  Future<void> searchSalons({required String salonQuery}) async {}
  // get salon base on categories
  Future<void> getSalonByCategories({required ServiceCategory category}) async {
    String? userCity = await _storageService.getUserCity();
    if (userCity == null) {
      // todo : should get user current city location
    }
    DataState<List<Salon>> result = await _apiServices.getSalonByCategories(
        city: userCity!, category: category);
    if (result is DataSuccesState) {
      // print(result.data);
      salonsBasedOnCategory = result.data!;
      update();
    }
    if (result is DataFailState) {
      // print(result.error);
      Get.offNamed(rErrorScreen, arguments: {'error': result.error});
    }
  }

  // get salons category
  Future<void> getSalonCategories() async {
    // isCategoryLoadign=true;
    // update();
    DataState<List<ServiceCategory>> resualt =
        await _apiServices.getCategoriesList();
    if (resualt is DataSuccesState) {
      salonCategories = resualt.data!;
      // isCategoryLoadign=false;
      update();
    }
    if (resualt is DataFailState) {
      // isCategoryLoadign=false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }

  Future<void> addSalonToBookMarkList(
      {required int salonId, required String userToken}) async {
    await _apiServices.addSalonToBookMarks(token: userToken, salonId: salonId);
  }

  Future<void> _getBookMarkedSalons() async {
    String? userToken = await _storageService.getuserToken();
    DataState<List<BookMarkedSalon>> resualt =
        await _apiServices.getBookMarkedSalons(userToken: userToken!);
    if (resualt is DataSuccesState) {
      bookMarkedSalons = resualt.data!;
      update();
    }
    if (resualt is DataFailState) {
      bookMarkedSalons = [];
      update();
    }
  }

  Future<void> _getCitySalonsAvailable()async{
    DataState<List<City>>cities=await _apiServices.getAvailableCities();
    if(cities is DataSuccesState){
      availableCities=cities.data!;
      update();
    }else{
      availableCities=[];
      update();
    }

  } 

  Future<void> getHomeFeedSalons(String citylocation) async {
    log('============Fetchig Home Iteams============');
    isLoading = true;
    update();

    // todo should get user current city
    await getNewesSalons(cityName: citylocation);
    await getBestSalons(cityName: citylocation);
    await getSalonCategories();
    await _getBookMarkedSalons();
    await _getCitySalonsAvailable();
    isLoading = false;
    update();
  }

  updateInternetConnection(ConnectivityStatus status) {
    connectivityStatus = status;
    update();
  }

  // opens the home darwer
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() {
    super.onInit();
    _subscription = InternetConnectivityService()
        .connectivityResultStream()
        .listen((event) => updateInternetConnection(event));
    String ? cityName=Get.arguments['city'];
    getHomeFeedSalons(cityName??'Tehran');
  }

  @override
  void onClose() async{
   await _subscription.cancel();
    super.onClose();
  }
}
