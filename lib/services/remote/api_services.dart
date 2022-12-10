import "package:dio/dio.dart";

import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/category_model/category_model.dart';
import 'package:sibzamini/models/comment_model/comment_model.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/models/services_model/services_model.dart';
import 'package:sibzamini/models/user_model/user_modle.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/services/remote/request_monitoring.dart';

class ApiServices extends Interceptor {
  // DIO CONFIGURATION
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://sunict.ir/api/v1',
      headers: {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'Authorization': 'x5rjvhs4dnq3k4ael7yfrr0xk4et9gzumbgyzw88q3u6yp529q',
      },
    ),
  )..interceptors.add(ApiInterCeptor());

  // sends name and user phone number to create account
  Future<DataState<User>> createUserAccount(
      {required String name,
      required String phoneNumber,
      required String city}) async {
    try {
      FormData data =
          FormData.fromMap({'name': name, 'mobile': phoneNumber, 'city': city});
      Response response = await _dio.post(register, data: data);
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
      Response response = await _dio.post(loginCheck, data: data);
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

      Response response = await _dio.post(login, data: data);
      // print(response.data);
      if (response.statusCode == 200) {
        return DataSuccesState(true);
      }
      if (response.statusCode == 404) {
        return DataFailState(USER_NOT_FOUND);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(e.toString());
    }
  }

  // returns list of salons based on type of salons[best,newest] wirh corsponding city
  Future<DataState<List<Salon>>> getSalonList(
      {required String cityName, required String path}) async {
    try {
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
      Response response = await _dio.get('$salonInfo/$id');
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
      Response response = await _dio.post(salonComments, data: data);
      if (response.statusCode == 200) {
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
      FormData data = FormData.fromMap({
        'city': city,
        'category': category.slug,
      });
      Response response = await _dio.post(searchSalon, data: data);
      if (response.statusCode == 200) {
        List<dynamic> rawData = response.data;
        List<Salon> salons = rawData.map((e) => Salon.fromJson(e)).toList();
        return DataSuccesState(salons);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
      // if(response.statusCode==)
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  // returns list of salon base on user search
  Future<DataState<List<Salon>>> getSalonBySearch(
      {required String query, required String city}) async {
    try {
      FormData data = FormData.fromMap({'city': city, 'query': query});
      Response response = await _dio.post(searchSalon, data: data);
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

  sendComment() {
    // TODO: impelement the user post comment
  }
// returns Salon services based on salon id passed
  Future<DataState<List<SalonService>>> getSingleSalonServices(
      {required int salonId}) async {
    try {
      Response response = await _dio.get('$salonServices/$salonId');
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

  bookMarkSalon() {
    // TODO:Implement the user book mark salon
  }

  getBookMarkedSalons() {
    // TODO: implement the getting book mark list
  }

  deleteSalonBookMark() {
    // TODO : implement the deletig salon from the book mark list
  }
  // returns list of Services categories
  Future<DataState<List<ServiceCategory>>> getCategoriesList() async {
    try {
      Response response = await _dio.get(categories);
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

  getUserCityLocation() {
    // TODO: impelenet the  user city from lat and long
  }
}
