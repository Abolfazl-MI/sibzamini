

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'dart:developer';

class SharedStorageService {
  SharedPreferences? _pref;
  final String _token = 'token';
  // initiate the pref service at main
  Future<void> initPerfs() async {
    _pref = await SharedPreferences.getInstance();
  }

  // saves user token to shared db
  Future<void> saveUserToken(String value) async {
    try {
      await _pref!.setString(_token, value);
    } catch (e) {
      log(e.toString());
    }
  }

// deletes user id form db
  Future<void> deleteUserToken() async {
    try {
      await _pref!.remove(_token);
    } catch (e) {
      log(e.toString());
    }
  }

// return userId
  Future getuserToken() async {
    try {
      String? userId = _pref!.getString(_token);
      return userId;
    } catch (e) {
      log(e.toString());
    }
  }

  // cheecks if user  had logedin before or not
  Future <bool> checkLogin() async {
    try {
      String? token = _pref!.getString(_token);
      if (token == null) {
        return false;
      }
      if (token != null) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
