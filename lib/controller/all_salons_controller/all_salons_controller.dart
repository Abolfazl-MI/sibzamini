import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/api_services.dart';
import 'package:sibzamini/services/local/shared_service.dart';
import 'package:sibzamini/services/local/location_service.dart';

class AllSalonsController extends GetxController {
  //depndencies
  final ApiServices _apiServices = ApiServices();
  final SharedStorageService _storageService = SharedStorageService();
  final LocationServices _locationServices = LocationServices();
  // variables
  List<Salon> salons = [];
  List<BookMarkedSalon> bookMarkedSalons = [];
  String? userCurrentCity;
  bool isLoading = false;
  bool isMoreLoading = false;
  bool isMoreLoadingEnd = false;
  String? salonType;
  String? salonCategory;
  // pagenatio counter
  int _pageCount = 1;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  // methods
  /// gets list of salons basesd on best or newest
  Future<void> _getSalonsData(String? type) async {
    if (type != null) {
      await _apiServices
          .getSalonList(
        cityName: userCurrentCity ?? 'Tehran',
        path: type == 'best'
            ? ApiUrls.bestSalons
            : type == 'newest'
                ? ApiUrls.newestSalon
                : ApiUrls.bestSalons,
      )
          .then((DataState dataState) {
        if (dataState is DataSuccesState) {
          salons = dataState.data!;
          update();
        }
        if (dataState is DataFailState) {
          salons = [];
          update();
        }
      });
    }
  }

  Future<void> _getSalonByCategory(ServiceCategory? serviceCategory) async {
    if (serviceCategory != null) {
      await _apiServices
          .getSalonByCategories(
              city: userCurrentCity ?? 'Tehran', category: serviceCategory)
          .then(
        (DataState dataState) {
          if (dataState is DataSuccesState) {
            salons = dataState.data;
            update();
          }
          if (dataState is DataFailState) {
            salons = [];
            update();
          }
        },
      );
    }
  }

  /// gets userLocation
  Future<void> _getUserLocation() async {
    String? city = await _storageService.getUserCity();
    if (city == null) {
      _locationServices.getUserCityLocation().then((value) async {
        if (value is DataSuccesState) {
          userCurrentCity = value.data;
          await _storageService.saveUserCity(value.data!);
        } else {
          userCurrentCity = 'Tehran';
        }
      });
    } else {
      userCurrentCity = city;
      update();
    }
  }

  /// gets bookmarked salons
  Future<void> _getBookMarkedSaloons() async {
    String? token = await _storageService.getuserToken();
    if (token != null) {
      await _apiServices
          .getBookMarkedSalons(userToken: token)
          .then((DataState dataState) {
        if (dataState is DataSuccesState) {
          bookMarkedSalons = dataState.data!;
          update();
        }
        if (dataState is DataFailState) {
          bookMarkedSalons = [];
          update();
        }
      });
    }
  }

  /// callss screen needs function at one place
  Future<void> _getData(String? type,ServiceCategory?serviceCategory) async {
    salonType = type;
    isLoading = true;
    update();
    await _getUserLocation();
    await _getBookMarkedSaloons();
    await _getSalonsData(type);
    await _getSalonByCategory(serviceCategory);
    isLoading = false;
    update();
  }

  /// opens drawer
  openDrawer() {
    drawerKey.currentState!.openDrawer();
  }

  /// checks if salon is book marked
  doseSalonBookedMarked() {
    for (int index = 0; index < salons.length; index++) {
      if (bookMarkedSalons.contains(salons[index])) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// load more salons base on `best` or `newest`
  Future<void> loadMoreSalons() async {
    _pageCount++;
    update();
    await _apiServices
        .getSalonList(
            cityName: userCurrentCity ?? 'Tehran',
            path: salonType == 'best'
                ? ApiUrls.bestSalons
                : salonType == 'newest'
                    ? ApiUrls.newestSalon
                    : ApiUrls.bestSalons,
            pageCount: _pageCount)
        .then((DataState dataState) {
      if (dataState is DataSuccesState) {
        if (dataState.data.isNotEmpty) {
          salons += dataState.data;
          print(salons.length);
          update();
        }
        if (dataState.data.isEmpty || dataState.data == null) {
          isMoreLoadingEnd = true;
          update();
        }
      }
      if (dataState is DataFailState) {
        isMoreLoadingEnd = true;
        update();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    _getData(Get.arguments['type'],Get.arguments['salonCategory']);
  }
}
