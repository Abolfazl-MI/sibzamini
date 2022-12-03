import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/api_services.dart';

class HomeController extends GetxController {
  // dependencies
  final ApiServices _apiServices = ApiServices();

  // variables
  List<Salon> bestSalonsList = [];
  List<Salon> newestSalonList = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading=false;
  //methods
  // get best Salons
  Future<void> getBestSalons({required String cityName}) async {
    isLoading=true;
    update();
    DataState<List<Salon>> result =
        await _apiServices.getSalonList(cityName: cityName, path: bestSalons);
    if (result is DataSuccesState) {
      if (result.data != null) {
        bestSalonsList = result.data!;
        isLoading=false;
        update();
      }
    }
    if (result is DataFailState) {
      isLoading=false;
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
    if(resualt is DataFailState){
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }

  // search Salons
  Future<void> searchSalons({required String salonQuery}) async {}
  // get categories
  Future<void> getSalonCategories() async {}

  // opens the home darwer
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
