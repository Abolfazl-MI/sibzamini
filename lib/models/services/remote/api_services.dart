import "package:dio/dio.dart";
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';
import 'package:sibzamini/models/services/remote/api_const.dart';
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


  Future <DataState<User>> createUserAccount({
    required FormData data
  }) async {
    try {
      Response response= await _dio.post(register, data:data);
      if(response.statusCode==200){
        User user=User.fromJson(response.data);
        return DataSuccesState(user);
      }
      return DataFailState(SOMETHING_WENT_WRONG);
    } catch (e) {
      return DataFailState(SOMETHING_WENT_WRONG);
    }
  }

  confirmUserOtp({required String otpCode}) async {
    // TODO: Impelement the user otp code confirmation
  }

  loginUserAccount({required String userPhoneNumber}) {
    // TODO: Implement the user login
  }

  getSalonList({required String cityName}) {
    // TODO:impelemnt the getting list of sallons
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


  cancleRequest(){
     return CancelToken().cancel();
  }
}
