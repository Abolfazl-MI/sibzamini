import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageService {
   late SharedPreferences _pref;

  Future<void> init()async{
   _pref= await SharedPreferences.getInstance();
  }
  final String _token = 'token';
  final String _city = 'city';
  
  SharedStorageService(){
    init();
  }

  // saves user token to shared db
  Future<void> saveUserToken(String value) async {
    await _pref.setString(_token, value);
  }

// deletes user id form db
  Future<void> deleteUserToken() async {
    await _pref.remove(_token);
  }

// return userId
  Future<String?> getuserToken() async {
    return _pref.getString(_token);
  }

  // cheecks if user  had logedin before or not
  Future<bool> checkLogin() async {
    String? token = _pref.getString(_token);
    if (token == null) {
      return false;
    }
    if (token.isNotEmpty) {
      return true;
    }
    return false;
  }
  // saves user city
  Future<void> saveUserCity(String city) async {
    await _pref.setString(_city, city);
  }
  //deletes user city
  Future<void> deleteUserCity() async {
    await _pref.remove(_city);
  }
  // returns the user city
  Future<String?> getUserCity() async {
    return _pref.getString(_city);
  }
}
