
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageService {
  SharedPreferences ? pref;

  Future<void> init()async{
   pref= await SharedPreferences.getInstance();
  }
  final String _token = 'token';
  final String _city = 'city';
  final String _userId='userId';
  
  SharedStorageService(){
    init();
  }

  // saves user token to shared db
  Future<void> saveUserToken(String value) async {
    pref ??= await SharedPreferences.getInstance();
    await pref!.setString(_token, value);
  }

// deletes user id form db
  Future<void> deleteUserToken() async {
    pref ??= await SharedPreferences.getInstance();
    await pref!.remove(_token);
  }

// return userId
  Future<String?> getuserToken() async {
    pref ??= await SharedPreferences.getInstance();
    return pref!.getString(_token);
  }

  // cheecks if user  had logedin before or not
  Future<bool> checkLogin() async {
    pref ??= await SharedPreferences.getInstance();
    String? token = pref!.getString(_token);
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
    pref ??= await SharedPreferences.getInstance();
    await pref!.setString(_city, city);
  }
  //deletes user city
  Future<void> deleteUserCity() async {
    pref ??= await SharedPreferences.getInstance();
    await pref!.remove(_city);
  }
  // returns the user city
  Future<String?> getUserCity() async {
    pref ??= await SharedPreferences.getInstance();
    return pref!.getString(_city);
  }
  // saves user id
  Future<void> saveUserId(int id)async{
    pref ??= await SharedPreferences.getInstance();
    await pref!.setInt(_userId, id);
  }
  // returns user id 
  Future<int?>getUserId()async{
    pref ??= await SharedPreferences.getInstance();
    return pref!.getInt(_userId);
  }
}