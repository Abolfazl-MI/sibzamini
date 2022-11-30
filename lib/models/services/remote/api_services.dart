import "package:dio/dio.dart";

class ApiServices {
 final Dio _dio = Dio(BaseOptions(baseUrl: 'http://sunict.ir/api/v1', headers: {
    'Accept': 'application/json',
    'Authorization': 'x5rjvhs4dnq3k4ael7yfrr0xk4et9gzumbgyzw88q3u6yp529q',
  },),);
// 442->phonenumber


  createUserAccount({
    required String phoneNumber,
    required String name,
    required String city,
  }) async {

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
}
