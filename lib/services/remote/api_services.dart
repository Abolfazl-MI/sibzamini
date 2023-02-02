import 'dart:developer';

import "package:dio/dio.dart";

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/add_banner_model/add_banner_model.dart';
import 'package:sibzamini/models/bookmarked_salon_model/book_marked_salon_model.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/cities_model/cities_model.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/models/services_model/services_model.dart';
import 'package:sibzamini/models/user_model/user_modle.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/request_monitoring.dart';
import 'package:sibzamini/views/global/constants/map_token.dart';

class ApiServices {
  /// DIO CONFIGURATION
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http:///sunict.ir/api/v1',
      headers: {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'Authorization': 'x5rjvhs4dnq3k4ael7yfrr0xk4et9gzumbgyzw88q3u6yp529q',
      },
    ),
  )..interceptors.add(ApiInterCeptor());
  // for pagenation of salons
  final int _pageCount=1;
  /// sends name and user phone number to create account
  Future<DataState<User>> createUserAccount(
      {required String name,
      required String phoneNumber,
      required String city}) async {
    try {
      FormData data =
          FormData.fromMap({'name': name, 'mobile': phoneNumber, 'city': city});
      Response response = await _dio.post(ApiUrls.register, data: data);
      // print(response.data);

      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        return DataSuccesState(user);
      }
      if (response.statusCode == 422) {
        return DataFailState(response.data['errors']['mobile'][0]);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } on DioError catch (e) {
      if (e.response!.statusCode == 422) {
        return DataFailState(e.response!.data['errors']['mobile'][0]);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // sends phone number and otp token in order to confrim user login
  Future<DataState<User>> confirmUserOtp(
      {required String otpCode, required String phoneNumber}) async {
    try {
      FormData data =
          FormData.fromMap({'mobile': phoneNumber, 'token': otpCode});
      Response response = await _dio.post(ApiUrls.loginCheck, data: data);
      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        return DataSuccesState(user);
      }
      if (response.statusCode == 404 &&
          response.data['response'] == "invalid token") {
        return DataFailState('کد وارد شده صحیح نمیباشد');
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // request otp from server with phone  number passed
  Future<DataState<bool>> requestOtpCode({required String phoneNumber}) async {
    try {
      FormData data = FormData.fromMap({'mobile': phoneNumber});

      Response response = await _dio.post(ApiUrls.login, data: data);
      // print(response.data);
      if (response.statusCode == 200) {
        return DataSuccesState(true);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        return DataFailState(USER_NOT_FOUND);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(e.toString());
    }
  }

  // returns list of salons based on type of salons[best,newest] wirh corsponding city
  Future<DataState<List<Salon>>> getSalonList(
      {required String cityName, required String path,int?pageCount}) async {
    try {
      if(pageCount!=null){
          _dio.options.queryParameters={
            'page':pageCount
          };
          
      }
      FormData data = FormData.fromMap({'city': cityName});
      Response response = await _dio.post(path, data: data);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data['data'];
        List<Salon> salons = rawData.map((e) => Salon.fromJson(e)).toList();
        return DataSuccesState(salons);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // returns corsponding salon detail based on id passed
  Future<DataState<Salon>> getSalonDetail({required int id}) async {
    try {
      Response response = await _dio.get('${ApiUrls.salonInfo}/$id');
      if (response.statusCode == 200) {
        Salon salon = Salon.fromJson(response.data);
        return DataSuccesState(salon);
      }
      if (response.statusCode == 404) {
        return DataFailState(SALON_NOT_FOUND);
      }
      return DataFailState(SALON_NOT_FOUND);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // returns corsponding salon comments based on id passed
  Future<DataState<List<Comment>>> getSalonComments({required int id}) async {
    try {
      FormData data = FormData.fromMap({'salon': id});
      Response response = await _dio.post(ApiUrls.salonComments, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        List<dynamic> rawData = response.data;
        List<Comment> comments =
            rawData.map((e) => Comment.fromJson(e)).toList();
        return DataSuccesState(comments);
      }
      if (response.statusCode == 422) {
        return DataFailState(SALON_NOT_FOUND);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // retutrns list of salon based on selected category and city
  Future<DataState<List<Salon>>> getSalonByCategories({
    required String city,
    required ServiceCategory category,
  }) async {
    try {
      FormData data = FormData.fromMap(
          {'city': city, 'category': category.slug, 'query': ''});
      Response response = await _dio.post(ApiUrls.searchSalon, data: data);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<Salon> salons = rawData.map((e) => Salon.fromJson(e)).toList();
        return DataSuccesState(salons);
      }
      return DataFailState(SOMETHING_WENT_WRONG);

      /// if(response.statusCode==)
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// returns list of salon base on user search
  Future<DataState<List<Salon>>> getSalonBySearch(
      {required String query, required String city}) async {
    try {
      FormData data = FormData.fromMap({'city': city, 'query': query,'category':''});
      Response response = await _dio.post(ApiUrls.searchSalon, data: data);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<Salon> searchedSalons =
            rawData.map((e) => Salon.fromJson(e)).toList();
        return DataSuccesState(searchedSalons);
      }
      if (response.statusCode == 404) {
        return DataFailState(NO_THING_FIND);
      }
      return DataFailState(NO_THING_FIND);
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        return DataFailState(NO_THING_FIND);
      }
      return DataFailState(NO_THING_FIND);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }
  /// adds comments for salon with id given
  Future<DataState<bool>> sendComment(
      {required int salonId,
      required String userToken,
      required String comment,
      required int rate}) async {
    try {
      FormData data = FormData.fromMap({
        'user': userToken,
        'salon': salonId,
        'comment': comment,
        'rate': rate,
        'parent': ''
      });
      Response response = await _dio.post(ApiUrls.newSalonComment, data: data);
      if (response.statusCode == 200) {
        return DataSuccesState(true);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      log(e.toString());
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// returns Salon services based on salon id passed
  Future<DataState<List<SalonService>>> getSingleSalonServices(
      {required int salonId}) async {
    try {
      Response response = await _dio.get('${ApiUrls.salonServices}/$salonId');
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<SalonService> salonServices =
            rawData.map((e) => SalonService.fromJson(e)).toList();
        return DataSuccesState(salonServices);
      }
      if (response.statusCode == 404) {
        return DataFailState(NO_THING_FIND);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        return DataFailState(NO_THING_FIND);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// added coresponding salon to user bookmark list
  Future<DataState<bool>> addSalonToBookMarks(
      {required String token, required int salonId}) async {
    try {
      FormData data = FormData.fromMap({
        'user': token,
        'salon': salonId,
      });
      Response response = await _dio.post(ApiUrls.bookMarkSalon, data: data);
      if (response.statusCode == 200) {
        return DataSuccesState(true);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return DataFailState('این سالن از قبل اضافه شده است');
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// returns list of user bookmarked salons
  Future<DataState<List<BookMarkedSalon>>> getBookMarkedSalons(
      {required String userToken}) async {
    try {
      FormData data = FormData.fromMap({'user': userToken});
      Response response = await _dio.post(ApiUrls.bookMarkList, data: data);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<BookMarkedSalon> bookMarkedSalons =
            rawData.map((e) => BookMarkedSalon.fromJson(e)).toList();
        return DataSuccesState(bookMarkedSalons);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// deletes salon from user bookmarked salons base on the id of salon
  Future<DataState<bool>> deleteSalonFromBookMarkList(
      {required String userToken, required int salonId}) async {
    try {
      FormData data = FormData.fromMap({'user': userToken, 'salon': salonId});
      Response response =
          await _dio.post(ApiUrls.deleteSalonBookMark, data: data);
      if (response.statusCode == 200) {
        return DataSuccesState(true);
      }
      return DataSuccesState(false);
    } catch (e) {
      return DataSuccesState(false);
    }
  }

  /// returns list of Services categories
  Future<DataState<List<ServiceCategory>>> getCategoriesList() async {
    try {
      Response response = await _dio.get(ApiUrls.categories);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<ServiceCategory> categories =
            rawData.map((e) => ServiceCategory.fromJson(e)).toList();
        return DataSuccesState(categories);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// gets user city name base on lat and long passed
  /// would return city name in english like Tehran
  Future<DataState<String>> getUserCityLocation(
      {required double lat, required double lon}) async {
    try {
      _dio.options.baseUrl = 'https:///map.ir';
      _dio.options.headers.addAll({'x-api-key': map_token});
      Response response = await _dio.get('/fast-reverse', queryParameters: {
        'lat': lat,
        'lon': lon,
      });
      if (response.statusCode == 200) {
        String city = response.data['province'];
        return DataSuccesState(city);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// gets salons adds banner
  Future getSalonsAddsBanner() async {}

  /// gets salons avilable cities list
  /// if response 200 would return `List<City>`
  /// else would return `SOME THING WENT wrong`
  Future<DataState<List<City>>> getAvailableCities() async {
    try {
      Response response = await _dio.get(ApiUrls.cities);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<City> cities = rawData.map((data) => City.fromJson(data)).toList();
        return DataSuccesState(cities);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  /// gets application banner adds from server
  /// if response 200 would return `List<SalonAddBanner>`
  /// else whoul return `SOME THING WENT WONG `
  Future<DataState<List<SalonAddBanner>>> getSalonAddsBanner() async {
    try {
      Response response = await _dio.get(ApiUrls.adds);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<SalonAddBanner> salonAddBanner =
            rawData.map((e) => SalonAddBanner.fromJson(e)).toList();
        return DataSuccesState(salonAddBanner);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } on DioError catch (e) {
      return DataFailState(e.message);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }
}
