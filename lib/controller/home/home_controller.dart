import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import '';
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
  List<SalonCategory> salonCategories = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isCategoryLoadign=false;
  //methods
  // get best Salons
  Future<void> getBestSalons({required String cityName}) async {
    isLoading = true;
    update();
    DataState<List<Salon>> result =
        await _apiServices.getSalonList(cityName: cityName, path: bestSalons);
    if (result is DataSuccesState) {
      if (result.data != null) {
        bestSalonsList = result.data!;
        isLoading = false;
        update();
      }
    }
    if (result is DataFailState) {
      isLoading = false;
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
          backgroundColor: Colors.red);
    }
  }

  // get news Salons
  Future<void> getNewesSalons({required String cityName}) async {
    DataState<List<Salon>> resualt =
        await _apiServices.getSalonList(cityName: cityName, path: newestSalon);
    if (resualt is DataSuccesState) {
      if (resualt.data != null) {
        newestSalonList = resualt.data!;
        update();
      }
    }
    if (resualt is DataFailState) {
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }

  // search Salons
  Future<void> searchSalons({required String salonQuery}) async {}
  // get salon base on categories
  Future<void> getSalonByCategories({required SalonCategory category}) async {
    String? userCity = await _storageService.getUserCity();
    if (userCity == null) {
      // todo : should get user current city location
    }
    DataState<List<Salon>> result = await _apiServices.getSalonByCategories(
        city: userCity!, category: category);
    if (result is DataSuccesState) {
      salonsBasedOnCategory = result.data!;
      update();
    }
    if (result is DataFailState) {
      Get.offNamed(rErrorScreen, arguments: {'error': result.error});
    }
  }

  // get salons category
  Future<void>getSalonCategories()async{
    isCategoryLoadign=true;
    update();
    DataState<List<SalonCategory>> resualt= await _apiServices.categoriesList();
    if(resualt is DataSuccesState){
      salonCategories=resualt.data!;
      isCategoryLoadign=false;
      update();
    }
    if(resualt is DataFailState){
      isCategoryLoadign=false;
      update();
       Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }


  Future<void> getHomeFeedSalons({int? limit}) async {
    // todo should get user current city
    getNewesSalons(cityName: 'tehran');
    getBestSalons(cityName: 'tehran');
    getSalonCategories();
    print(bestSalonsList);
    print(newestSalonList);
  }

  // opens the home darwer
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeFeedSalons();
  }
}
