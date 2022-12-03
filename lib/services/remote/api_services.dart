import 'dart:developer';

import "package:dio/dio.dart";
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/salon_model/salon_model.dart';
import 'package:sibzamini/services/remote/api_const.dart';
import 'package:sibzamini/models/user_model/user_modle.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://sunict.ir/api/v1',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'x5rjvhs4dnq3k4ael7yfrr0xk4et9gzumbgyzw88q3u6yp529q',
      },
    ),
  );

  Future<DataState<User>> createUserAccount(
      {required String name,
      required String phoneNumber,
      required String city}) async {
    try {
      FormData data =
          FormData.fromMap({'name': name, 'mobile': phoneNumber, 'city': city});
      Response response = await _dio.post(register, data: data);
      print(response.data);
      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        return DataSuccesState(user);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

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

  Future<DataState<bool>> loginUserAccount(
      {required String phoneNumber}) async {
    try {
      FormData data = FormData.fromMap({'mobile': phoneNumber});

      Response response = await _dio.post(login, data: data);
      print(response.data);
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

  Future<DataState<List<Salon>>> getSalonList(
      {required String cityName, required String path}) async {
    try {
      FormData data = FormData.fromMap({'city': cityName});
      Response response = await _dio.post(path, data: data);
      if(response.statusCode==200){
          List<Map<String,dynamic>> rawData=response.data;
          List<Salon> salons=rawData.map((e) => Salon.fromJson(e)).toList();
          return DataSuccesState(salons);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  getSalonDetail() {
    // TODO: implement salon detail get
  }

  sendComment() {
    // TODO: impelement the user post comment
  }

  bookMarkSalon() {
    // TODO:Implement the user book mark salon
  }

  categoriesList() {
    // TODO:implement the  get categories
  }

  cancleRequest() {
    return CancelToken().cancel();
  }
}
