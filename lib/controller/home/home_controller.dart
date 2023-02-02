import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/add_banner_model/add_banner_model.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/local/connectivity_service.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/views/routes/app_route_names.dart';
import 'package:sibzamini/services/local/location_service.dart';

class HomeController extends GetxController {
  // dependencies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  final LocationServices _locationServices = LocationServices();

  // variables
  List<Salon> bestSalonsList = [];
  List<Salon> newestSalonList = [];
  List<Salon> salonsBasedOnCategory = [];
  List<ServiceCategory> salonCategories = [];
  List<BookMarkedSalon> bookMarkedSalons = [];
  List<City> availableCities = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> allSalonsScaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isCategoryLoadign = false;
  bool isFavSalonLoading = false;
  bool isDeleteFavLoading = false;
  bool isLoadMoreLoading = false;
  bool isLoadMoreSalonsEnd = false;
  // pagenation counter
  int _pageCount = 1;
  String? currentCity;
  ConnectivityStatus connectivityStatus = ConnectivityStatus.disconnected;
  List<SalonAddBanner> salonAddBanners = [];
  late final StreamSubscription<ConnectivityStatus> _subscription;

  //methods
  /// get best Salons from server
  /// if response is 200 `List<Salon>` wolld returned
  Future<void> getBestSalons({required String cityName}) async {
    DataState<List<Salon>> result = await _apiServices.getSalonList(
        cityName: cityName, path: ApiUrls.bestSalons);
    if (result is DataSuccesState) {
      if (result.data != null) {
        bestSalonsList = result.data!;
        update();
      }
    }
    if (result is DataFailState) {
      bestSalonsList=[];
      update();
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', result.error!,
          backgroundColor: Colors.red);
    }
  }

  _getSallonAddsBanner() async {
    _apiServices.getSalonAddsBanner().then((DataState result) {
      if (result is DataSuccesState) {
        salonAddBanners = result.data;
        update();
      } else {
        salonAddBanners = [];
        update();
      }
    });
  }

  // gets user current cityName from shared
  getUserCityLocationName() async {
    var result = await _storageService.getUserCity();
    currentCity = result;
    update();
  }

  // get news Salons
  Future<void> getNewesSalons({required String cityName}) async {
    DataState<List<Salon>> resualt = await _apiServices.getSalonList(
        cityName: cityName, path: ApiUrls.newestSalon);
    // print('{data:$}');

    if (resualt is DataSuccesState) {
      // print(resualt.data);
      if (resualt.data != null) {
        newestSalonList = resualt.data!;
        update();
      }
    }
    if (resualt is DataFailState) {
      newestSalonList=[];
      update();
      // print(resualt);
      Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', resualt.error!,
          backgroundColor: Colors.red);
    }
  }

  // get salon base on categories
  Future<void> getSalonByCategories({required ServiceCategory category}) async {
    print(category.name);
    String? userCity = await _storageService.getUserCity();
    if (userCity == null) {
      DataState<String> cityState =
          await _locationServices.getUserCityLocation();
      if (cityState is DataSuccesState) {
        userCity = cityState.data;
        _storageService.saveUserCity(cityState.data!);
        update();
      }
    }
    print(userCity);
    scaffoldKey.currentState!.closeDrawer();
    isLoading = true;
    update();
    await _apiServices
        .getSalonByCategories(city: userCity!, category: category)
        .then((DataState dataState) {
      if (dataState is DataSuccesState) {
        isLoading = false;
        update();
        Get.toNamed(rAllSalonsScreen, arguments: {'salons': dataState.data});
      } else {
        scaffoldKey.currentState!.closeDrawer();
        isLoading = false;
        update();
        Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', dataState.error!,
            backgroundColor: Colors.red);
      }
    });
  }

  // refreshes the favorite list
  Future<void> refreshFavSalons() async {
    isFavSalonLoading = true;
    update();
    String? token = await _storageService.getuserToken();
    if (token != null) {
      await _apiServices
          .getBookMarkedSalons(userToken: token)
          .then((DataState dataState) {
        if (dataState is DataSuccesState) {
          bookMarkedSalons = dataState.data;
          isFavSalonLoading = false;
          update();
        } else if (dataState is DataFailState) {
          Get.back();
          Get.snackbar('\u{1F610}' 'مشکلی پیش آمده', dataState.error!,
              backgroundColor: Colors.red);
        }
      });
    } else {
      Get.offNamed(rHomeScreen);
    }
  }

  // delete salon from favorites
  Future<void> deleteSalonFromFavorites(int salonIndex, int salonId) async {
    isDeleteFavLoading = true;
    update();
    String? token = await _storageService.getuserToken();
    if (token != null) {
      await _apiServices
          .deleteSalonFromBookMarkList(userToken: token, salonId: salonId)
          .then((DataState dataState) {
        if (dataState is DataSuccesState) {
          bookMarkedSalons.removeAt(salonIndex);
          isDeleteFavLoading = false;
          update();
        } else {
          Get.snackbar('مشکلی پیش آمده',
              "خطا درانجام عملیات لطفا در زمان دیگر دوباره تلاش کنید");
        }
      });
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

  Future<void> _getCitySalonsAvailable() async {
    DataState<List<City>> cities = await _apiServices.getAvailableCities();
    if (cities is DataSuccesState) {
      availableCities = cities.data!;
      update();
    } else {
      availableCities = [];
      update();
    }
  }

  Future<void> getHomeFeedSalons(String citylocation) async {
    log('============Fetchig Home Iteams============');
    isLoading = true;
    update();
    await getNewesSalons(cityName: citylocation);
    await getBestSalons(cityName: citylocation);
    await getSalonCategories();
    await _getBookMarkedSalons();
    await _getCitySalonsAvailable();
    await _getSallonAddsBanner();
    isLoading = false;
    update();
  }

  updateInternetConnection(ConnectivityStatus status) {
    connectivityStatus = status;
    update();
  }

  doseSalonBookedMarked(List<Salon> normalSalons) {
    for (int index = 0; index < normalSalons.length; index++) {
      if (bookMarkedSalons.contains(normalSalons[index])) {
        return true;
      } else {
        return false;
      }
    }
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
    String? cityName = Get.arguments['city'];
    getHomeFeedSalons(cityName ?? 'Tehran');
    getUserCityLocationName();
  }

  autoSelectLocation() async {
    await _locationServices.getUserCityLocation().then((DataState dataState) {
      if (dataState is DataSuccesState) {
        currentCity = dataState.data;
        update();
      }
      if (dataState is DataFailState) {
        currentCity = 'Tehran';
        update();
      }
    });
  }

  @override
  void onClose() async {
    await _subscription.cancel();
    super.onClose();
  }
}
